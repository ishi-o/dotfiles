local conf = require("config.dev.lsp.conf")

-- vim.lsp.config("basedpyright", {
-- 	on_attach = conf.on_attach,
-- 	capabilities = conf.capabilities,
-- 	settings = {
-- 		basedpyright = {
-- 			analysis = {
-- 				autoSearchPaths = true,
-- 				diagnosticMode = "openFilesOnly",
-- 				useLibraryCodeForTypes = true,
-- 			},
-- 		},
-- 	},
-- })

vim.lsp.config("ty", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
	settings = {
		ty = {
			inlayHints = {
				variableTypes = true,
				callArgumentNames = true,
			},
		},
	},
})
vim.lsp.enable("ty")

-- vim.lsp.config("ruff", {
-- 	on_attach = conf.on_attach,
-- 	capabilities = conf.capabilities,
-- 	init_options = {
-- 		settings = {
-- 			configuration = {
-- 				lint = {
-- 					unfixable = { "F401" },
-- 					["extend-select"] = { "TID251" },
-- 					["flake8-tidy-imports"] = {
-- 						["banned-api"] = {
-- 							["typing.TypedDict"] = {
-- 								msg = "Use `typing_extensions.TypedDict` instead",
-- 							},
-- 						},
-- 					},
-- 				},
-- 				format = {
-- 					["quote-style"] = "single",
-- 				},
-- 			},
-- 			organizeImports = true,
-- 			showSyntaxErrors = true,
-- 			logLevel = "debug",
-- 		},
-- 	},
-- })
-- vim.lsp.enable("ruff")
