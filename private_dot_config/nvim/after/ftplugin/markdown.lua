vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.expandtab = false

local lang_indent_map = {
	python = { expandtab = false, tabstop = 4, shiftwidth = 4 },
	go = { expandtab = false, tabstop = 4, shiftwidth = 4 },
	c = { expandtab = false, tabstop = 4, shiftwidth = 4 },
	cpp = { expandtab = false, tabstop = 4, shiftwidth = 4 },
	java = { expandtab = false, tabstop = 4, shiftwidth = 4 },
	javascript = { expandtab = false, tabstop = 4, shiftwidth = 4 },
	typescript = { expandtab = false, tabstop = 4, shiftwidth = 4 },
	rust = { expandtab = false, tabstop = 4, shiftwidth = 4 },
	ruby = { expandtab = false, tabstop = 4, shiftwidth = 4 },
	php = { expandtab = false, tabstop = 4, shiftwidth = 4 },
	sh = { expandtab = false, tabstop = 4, shiftwidth = 4 },
	bash = { expandtab = false, tabstop = 4, shiftwidth = 4 },
	zsh = { expandtab = false, tabstop = 4, shiftwidth = 4 },
	html = { expandtab = false, tabstop = 4, shiftwidth = 4 },
	css = { expandtab = false, tabstop = 4, shiftwidth = 4 },
	scss = { expandtab = false, tabstop = 4, shiftwidth = 4 },
	json = { expandtab = false, tabstop = 4, shiftwidth = 4 },
	yaml = { expandtab = false, tabstop = 4, shiftwidth = 4 },
	toml = { expandtab = false, tabstop = 4, shiftwidth = 4 },
	sql = { expandtab = false, tabstop = 4, shiftwidth = 4 },
	lua = { expandtab = false, tabstop = 4, shiftwidth = 4 },
}
local current_state = {
	in_code_block = false,
	current_lang = nil,
	code_block_range = { start_line = -1, end_line = -1 },
}
local function get_code_lang_at_cursor_optimized()
	local cursor_line = vim.fn.line(".") - 1 -- 0-based

	if current_state.in_code_block then
		if
			cursor_line >= current_state.code_block_range.start_line
			and cursor_line <= current_state.code_block_range.end_line
		then
			return nil
		else
			current_state.in_code_block = false
			current_state.current_lang = nil
			current_state.code_block_range = { start_line = -1, end_line = -1 }
			return "exit_code_block"
		end
	end

	local start_line = -1
	local lang = nil
	for l = cursor_line, 0, -1 do
		local line_text = vim.fn.getline(l + 1)
		if line_text:match("^```") then
			start_line = l
			lang = line_text:match("^```%s*(%S+)")
			break
		end
	end

	if start_line == -1 then
		return nil
	end

	for l = start_line + 1, vim.fn.line("$") - 1 do
		local line_text = vim.fn.getline(l + 1)
		if line_text:match("^```") then
			local end_line = l
			if cursor_line > start_line and cursor_line < end_line then
				current_state.in_code_block = true
				current_state.current_lang = lang
				current_state.code_block_range = { start_line = start_line, end_line = end_line }
				return lang and lang_indent_map[lang] or nil
			else
				return nil
			end
		end
	end

	return nil
end

local apply_indent_timer = nil
local function apply_indent_settings()
	if apply_indent_timer then
		apply_indent_timer:close()
	end

	apply_indent_timer = vim.defer_fn(function()
		local indent_opts = get_code_lang_at_cursor_optimized()

		if indent_opts == "exit_code_block" then
			vim.bo.expandtab = true
			vim.bo.tabstop = 2
			vim.bo.shiftwidth = 2
		elseif indent_opts then
			-- 进入或停留在代码块内，应用对应语言设置
			vim.bo.expandtab = indent_opts.expandtab
			vim.bo.tabstop = indent_opts.tabstop
			vim.bo.shiftwidth = indent_opts.shiftwidth
		end
		apply_indent_timer = nil
	end, 50)
end

vim.api.nvim_create_augroup("MarkdownCodeBlockIndent", { clear = true })
vim.api.nvim_create_autocmd({ "InsertLeave", "CursorHold", "WinScrolled" }, {
	pattern = "*.md,*.markdown",
	group = "MarkdownCodeBlockIndent",
	callback = apply_indent_settings,
})
