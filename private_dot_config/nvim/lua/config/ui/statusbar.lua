require("nvim-navic").setup({
	icons = {
		File = " ",
		Module = " ",
		Namespace = " ",
		Package = " ",
		Class = " ",
		Method = " ",
		Property = " ",
		Field = " ",
		Constructor = " ",
		Enum = " ",
		Interface = " ",
		Function = " ",
		Variable = " ",
		Constant = " ",
		String = " ",
		Number = " ",
		Boolean = " ",
		Array = " ",
		Object = " ",
		Key = " ",
		Null = " ",
		EnumMember = " ",
		Struct = " ",
		Event = " ",
		Operator = " ",
		TypeParameter = " ",
	},
	-- icons = {
	-- 	File = " ",
	-- 	Module = " ",
	-- 	Namespace = " ",
	-- 	Package = " ",
	-- 	Class = " ",
	-- 	Method = " ",
	-- 	Property = " ",
	-- 	Field = " ",
	-- 	Constructor = " ",
	-- 	Enum = " ",
	-- 	Interface = " ",
	-- 	Function = "󰊕 ",
	-- 	Variable = "󰫧 ",
	-- 	Constant = "󰫧 ",
	-- 	String = " ",
	-- 	Number = " ",
	-- 	Boolean = " ",
	-- 	Array = " ",
	-- 	Object = " ",
	-- 	Key = " ",
	-- 	Null = "󰟢 ",
	-- 	EnumMember = " ",
	-- 	Struct = " ",
	-- 	Event = " ",
	-- 	Operator = " ",
	-- 	TypeParameter = " ",
	-- },
	highlight = true,
	separator = "  ",
	depth_limit = 0,
	depth_limit_indicator = "..",
	-- format_text = function(symbols)
	-- 	local wanted_types = {
	-- 		Function = true,
	-- 		Method = true,
	-- 		Constructor = true,
	-- 		Interface = true,
	-- 		Class = true,
	-- 		Struct = true,
	-- 	}
	-- 	local filtered = {}
	-- 	for _, symbol in ipairs(symbols) do
	-- 		if wanted_types[symbol.type] then
	-- 			table.insert(filtered, symbol.name)
	-- 		end
	-- 	end
	-- 	if #filtered == 0 then
	-- 		return ""
	-- 	end
	-- 	return table.concat(filtered, "  ")
	-- end,
})

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = { "NvimTree", "alpha", "dashboard" },
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff" },
		lualine_c = {
			{
				"filename",
				path = 1,
				symbols = {
					modified = " [+]",
					readonly = " [-]",
					unnamed = "[未命名]",
				},
			},
			{
				require("noice").api.status.message.get_hl,
				cond = require("noice").api.status.message.has,
			},
		},
		lualine_x = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				sections = { "error", "warn", "info", "hint" },
				symbols = {
					error = " ",
					warn = " ",
					info = " ",
					hint = " ",
				},
				colored = true,
				always_visible = false,
			},
			"filetype",
			"encoding",
			"fileformat",
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	winbar = {
		lualine_a = {
			{
				function()
					local navic = require("nvim-navic")
					if navic.is_available() then
						local location = navic.get_location()
						return location and #location > 0 and location or " "
					else
						return " "
					end
				end,
				color = { fg = "#d4d4d4", gui = "bold" },
			},
		},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	inactive_winbar = {
		lualine_a = {
			{
				function()
					return " "
				end,
			},
		},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = { "nvim-tree", "toggleterm", "fzf" },
})
