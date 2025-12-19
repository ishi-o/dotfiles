require("noice").setup({
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
		inc_rename = false,
		lsp_doc_border = false,
	},
	messages = {
		enabled = true,
		view = "notify",
	},
	cmdline = {
		enabled = true,
		opts = {
			size = {
				min_width = math.floor(vim.o.columns * 0.6),
				max_width = math.floor(vim.o.columns * 0.6),
			},
			win_options = {
				wrap = true,
				linebreak = true,
			},
		},
	},
	lsp = {
		progress = { enabled = false },
		hover = {
			enabled = false,
		},
		signature = {
			enabled = false,
		},
	},
	notify = {
		enabled = true,
		view = "notify",
	},
	views = {
		hover = {
			border = "single",
			position = {
				row = 2,
				col = 0,
			},
		},
	},
})
require("telescope").load_extension("noice")
