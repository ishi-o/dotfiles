require("java").setup()
local conf = require("config.langservice.lsp.conf")
vim.lsp.config("jdtls", {
	on_attach = function(client, buf)
		conf.on_attach(client, buf)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
	capabilities = conf.capabilities,
	settings = {
		java = {
			signatureHelp = { enabled = true },
			inlayHints = { enabled = false },
		},
	},
})
vim.lsp.enable("jdtls")
