local conf = require("config.lsp.conf")

vim.lsp.config("gopls", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
})
vim.g.go_fmt_autosave = 1
vim.g.go_highlight_types = 1
vim.g.go_imports_mode = "goimports"
