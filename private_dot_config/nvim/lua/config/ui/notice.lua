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
	},
	lsp = {
		progress = { enabled = false },
		hover = {
			enabled = false,
			-- view = "notify",
		},
		signature = {
			enabled = true,
		},
	},
	notify = {
		enabled = true,
		view = "notify",
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
