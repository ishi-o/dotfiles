local conf = require("config.dev.lsp.conf")

-- vim.lsp.config("eslint", {
-- 	on_attach = conf.on_attach,
-- 	capabilities = conf.capabilities,
-- 	settings = {
-- 		eslint = {
-- 			enable = true,
-- 			validate = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
-- 		},
-- 	},
-- })

vim.lsp.config("ts_ls", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
})

-- vim.lsp.config("jsonnet_ls", {
-- 	on_attach = conf.on_attach,
-- 	capabilities = conf.capabilities,
-- })

vim.lsp.config("jsonls", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})
