local conf = require("config.langservice.lsp.conf")

vim.lsp.config("texlab", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
	filetypes = { "tex", "plaintex", "bib", "markdown" },
})
