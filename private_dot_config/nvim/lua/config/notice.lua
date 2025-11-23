require("noice").setup({
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
		inc_rename = false,
		lsp_doc_border = true,
	},
	messages = {
		enabled = true,
	},
	cmdline = {
		enabled = true,
	},
	lsp = {
		progress = { enabled = false },
		hover = {
			enabled = false,
			view = "notify",
		},
		signature = {
			enabled = true,
		},
	},
	notify = {
		enabled = true,
	},
})

require("fidget").setup({
	progress = {
		suppress_on_insert = true,
		display = {
			done_ttl = 1,
		},
		ignore_empty_message = true,
		ignore_done_already = true,
	},
})
