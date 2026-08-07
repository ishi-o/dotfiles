local ok, noice = pcall(require, "noice")
if not ok then
	return
end
noice.setup({
	presets = {
		bottom_search = true,
		command_palette = false,
		long_message_to_split = false,
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
		view = "cmdline",
		format = {
			input = {
				view = "cmdline"
			}
		}
	},
	lsp = {
		enabled = true,
		progress = { enabled = true },
		hover = { enabled = false, },
		signature = { enabled = false, },
	},
	views = {
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
