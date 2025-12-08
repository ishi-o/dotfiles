local conf = require("config.dev.lsp.conf")

vim.lsp.config("dockerls", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
})

vim.lsp.config("docker_compose_language_service", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
})
