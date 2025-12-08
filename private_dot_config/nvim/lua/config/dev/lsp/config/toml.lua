local conf = require("config.dev.lsp.conf")

vim.lsp.config("taplo ", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
})
