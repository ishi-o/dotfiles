require("gitsigns").setup()
require("scrollbar").setup({
	handle = { color = "#93B259", color_nr = 150 },
	marks = {
		Cursor = { text = "▬", color = "#000000" },
		Search = { text = { "▬" }, color = "#887700" },
		Error = { text = { "▬" }, color = "#FF5555", color_nr = 9 },
		Warn = { text = { "▬" }, color = "#E5C07B", color_nr = 3 },
		Info = { text = { "▬" }, color = "#55AAFF", color_nr = 12 },
		Hint = { text = { "▬" } },
		Misc = { text = { "▬" } },
		GitAdd = { text = "┃", color = "#2E8B57" },
		GitChange = { text = "┃", color = "#55AAFF" },
		GitDelete = { text = "┃", color = "#E06C75" },
	},
	excluded_filetypes = {
		"blink-cmp-menu",
		"dropbar_menu",
		"dropbar_menu_fzf",
		"DressingInput",
		"cmp_docs",
		"cmp_menu",
		"noice",
		"prompt",
		"TelescopePrompt",
		"snacks_picker_list",
		"snacks_picker_input",
		"snacks_dashboard",

		"dap-repl",
		"dapui_breakpoints",
		"dapui_console",
		"dapui_scopes",
		"dapui_watches",
		"dapui_stacks",
	},
})
require("scrollbar.handlers.search").setup({})
require("scrollbar.handlers.gitsigns").setup()
