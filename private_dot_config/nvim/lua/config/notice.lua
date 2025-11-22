-- require("noice").setup({
-- 	cmdline = { enabled = false },
-- 	messages = { enabled = false },
-- 	popupmenu = { enabled = true },
-- 	notify = { enabled = true },
-- 	lsp = {
-- 		progress = { enabled = false },
-- 		hover = { enabled = true },
-- 		signature = { enabled = true },
-- 	},
-- })
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
