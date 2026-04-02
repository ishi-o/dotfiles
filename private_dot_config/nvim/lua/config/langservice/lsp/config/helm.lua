local conf = require("config.langservice.lsp.conf")

vim.lsp.config("helm_ls", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
})
