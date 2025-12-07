local conf = require("config.dev.lsp.conf")

vim.lsp.config("eslint", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
	settings = {
		eslint = {
			enable = true,
			validate = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
		},
	},
})
