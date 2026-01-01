local conf = require("config.langservice.lsp.conf")

vim.lsp.config("buf_ls", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
})
