require("java").setup()
local conf = require("config.langservice.lsp.conf")
-- FIX: inlayHints out-of-range
-- when inlayhints and dap's virtual_text is both enabled
-- use dap.linters? to toggle vim.lsp.inlay_hint
vim.lsp.config("jdtls", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
	settings = {
		java = {
			inlayHints = {
				parameterNames = {
					enabled = "all",
				},
			},
			signatureHelp = { enabled = true },
		},
	},
})
vim.lsp.enable("jdtls")
