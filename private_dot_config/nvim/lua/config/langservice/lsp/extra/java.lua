require("java").setup()
local conf = require("config.langservice.lsp.conf")
vim.lsp.config("jdtls", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
})
vim.lsp.enable("jdtls")
