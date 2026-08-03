local ok, noice = pcall(require, "noice")
if not ok then
	return
end
noice.setup({
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
		inc_rename = false,
		lsp_doc_border = false,
	},
	messages = {
		enabled = true,
		view = "mini",
	},
	notify = {
		enabled = true,
		view = "mini",
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
		progress = { enabled = true },
		hover = {
			enabled = false,
		},
		signature = {
			enabled = false,
		},
	},
	views = {
		hover = {
			border = "single",
			position = {
				row = 2,
				col = 0,
			},
		},
		notify = {
			backend = {},
		},
		mini = {
			size = {
				max_width = math.floor(vim.o.columns * 0.3),
			},
			win_options = {
				wrap = true,
				linebreak = false,
			},
			timeout = 3000,
		},
	},
})
