local M = {}
local api = vim.api
local autocmd = _G.UserUtils.autocmd

local mode_names = {
	n = "NORMAL",
	no = "OP-PENDING",
	v = "VISUAL",
	V = "V-LINE",
	["\22"] = "V-BLOCK",
	s = "SELECT",
	S = "S-LINE",
	["\19"] = "S-BLOCK",
	i = "INSERT",
	R = "REPLACE",
	Rv = "V-REPLACE",
	c = "COMMAND",
	cv = "VIM-EX",
	ce = "EX",
	r = "PROMPT",
	t = "TERMINAL",
}

local mode_groups = {
	n = "MiniStatuslineModeNormal",
	no = "MiniStatuslineModeNormal",
	i = "MiniStatuslineModeInsert",
	v = "MiniStatuslineModeVisual",
	V = "MiniStatuslineModeVisual",
	["\22"] = "MiniStatuslineModeVisual",
	s = "MiniStatuslineModeVisual",
	S = "MiniStatuslineModeVisual",
	["\19"] = "MiniStatuslineModeVisual",
	R = "MiniStatuslineModeReplace",
	Rv = "MiniStatuslineModeReplace",
	c = "MiniStatuslineModeCommand",
	cv = "MiniStatuslineModeCommand",
	ce = "MiniStatuslineModeCommand",
	r = "MiniStatuslineModeCommand",
	t = "MiniStatuslineModeOther",
}

local disabled_filetypes = {
	NvimTree = true,
	alpha = true,
	dashboard = true,
}

local function add(values, value)
	if value and value ~= "" then
		table.insert(values, value)
	end
end

local function escape(value)
	return tostring(value or ""):gsub("%%", "%%%%")
end

local function join(values, separator)
	for index, value in ipairs(values) do
		values[index] = escape(value)
	end
	return table.concat(values, separator)
end

function M.render()
	local bufnr = api.nvim_get_current_buf()
	if disabled_filetypes[vim.bo[bufnr].filetype] then
		return ""
	end

	local mode_code = vim.fn.mode(1)
	local mode = mode_names[mode_code] or mode_code
	local git = ""

	do
		local status = vim.b[bufnr].gitsigns_status_dict
		if type(status) == "table" then
			local changes = {}
			for _, item in ipairs({
				{ key = "added", prefix = "+", highlight = "GitSignsAdd" },
				{ key = "changed", prefix = "~", highlight = "GitSignsChange" },
				{ key = "removed", prefix = "-", highlight = "GitSignsDelete" },
			}) do
				local count = status[item.key]
				if type(count) == "number" and count > 0 then
					table.insert(changes, "%#" .. item.highlight .. "#" .. item.prefix .. count .. "%*")
				end
			end

			git = escape(status.head)
			if #changes > 0 then
				git = git .. (#git > 0 and " " or "") .. table.concat(changes, " ")
			end
		end
	end

	local right = {}
	local recording = vim.fn.reg_recording()
	if recording ~= "" then
		add(right, "recording:@" .. recording)
	end

	do
		local clients = {}
		local seen = {}
		for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
			if client.name and not seen[client.name] then
				table.insert(clients, client.name .. " ✓")
				seen[client.name] = true
			end
		end
		add(right, table.concat(clients, ", "))
	end

	local diagnostic_status = ""
	do
		local diagnostics = {}
		local counts = vim.diagnostic.count(bufnr)
		for _, item in ipairs({
			{ severity = vim.diagnostic.severity.ERROR, icon = "", highlight = "DiagnosticError" },
			{ severity = vim.diagnostic.severity.WARN,  icon = "", highlight = "DiagnosticWarn" },
			{ severity = vim.diagnostic.severity.INFO,  icon = "", highlight = "DiagnosticInfo" },
			{ severity = vim.diagnostic.severity.HINT,  icon = "", highlight = "DiagnosticHint" },
		}) do
			local count = counts[item.severity] or 0
			if count > 0 then
				table.insert(diagnostics, "%#" .. item.highlight .. "#" .. item.icon .. " " .. count .. "%*")
			end
		end
		diagnostic_status = table.concat(diagnostics, " ")
	end

	local filetype = vim.bo[bufnr].filetype
	local encoding = vim.bo[bufnr].fileencoding ~= "" and vim.bo[bufnr].fileencoding or vim.o.encoding

	local cursor = api.nvim_win_get_cursor(0)
	local line_count = math.max(api.nvim_buf_line_count(0), 1)
	local progress = math.floor(cursor[1] * 100 / line_count)

	local filetype_icon, fileformat_icon = "", ""
	local ok, devicons = pcall(require, "nvim-web-devicons")
	if ok then
		local function icon_segment(icon, icon_hl)
			if not icon then
				return ""
			end
			return (icon_hl and "%#" .. icon_hl .. "#" or "") .. icon .. (icon_hl and "%*" or "")
		end

		local icon, icon_hl
		if filetype ~= "" then
			icon, icon_hl = devicons.get_icon_by_filetype(filetype, { default = true })
			filetype_icon = icon_segment(icon, icon_hl)
		end
		local fileformat = vim.bo[bufnr].fileformat
		local fileformat_name = fileformat == "unix" and "linux" or fileformat
		icon, icon_hl = devicons.get_icon(fileformat_name, fileformat_name, { default = true })
		fileformat_icon = icon_segment(icon, icon_hl)
	end

	local file_info = (filetype_icon ~= "" and filetype_icon .. " " or "")
		.. (filetype ~= "" and escape(filetype) .. " | " or "")
		.. escape(encoding)
		.. (fileformat_icon ~= "" and " " .. fileformat_icon or "")

	return "%#" .. (mode_groups[mode_code] or "MiniStatuslineModeOther") .. "# " .. mode .. " %*"
		.. (git ~= "" and " | " .. git or "")
		.. " | "
		.. "%f %m%r%="
		.. join(right, " | ")
		.. (diagnostic_status ~= "" and (#right > 0 and " | " or "") .. diagnostic_status or "")
		.. " | "
		.. file_info
		.. " | "
		.. escape(string.format("%3d%% %5d:%-4d", progress, cursor[1], cursor[2] + 1))
end

function M.setup()
	local function refresh()
		api.nvim_command("redrawstatus")
	end

	api.nvim_set_option_value("laststatus", 3, { scope = "global" })
	api.nvim_set_option_value("statusline", "%!v:lua.require('config.ui.statusbar').render()", { scope = "global" })

	autocmd({
		"BufEnter",
		"BufWritePost",
		"DiagnosticChanged",
		"DirChanged",
		"LspAttach",
		"LspDetach",
		"ModeChanged",
		"RecordingEnter",
		"RecordingLeave",
	}, { callback = refresh })
	autocmd("User", { pattern = { "GitSignsUpdate", "VeryLazy" }, callback = refresh })
end

return M
