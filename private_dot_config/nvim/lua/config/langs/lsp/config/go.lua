local conf = require("config.langs.lsp.conf")

vim.lsp.config("gopls", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
	root_dir = vim.fs.root(0, { "go.mod", ".git" }),
	settings = {
		gopls = {
			gofumpt = true,
			templateExtensions = { "tmpl", "gotmpl" },
			codelenses = {
				gc_details = false,
				generate = true,
				regenerate_cgo = true,
				run_govulncheck = true,
				test = true,
				tidy = true,
				upgrade_dependency = true,
				vendor = true,
			},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			analyses = {
				nilness = true,
				unusedparams = true,
				unusedwrite = true,
				useany = true,
			},
			usePlaceholders = true,
			completeUnimported = true,
			staticcheck = true,
			directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
			semanticTokens = false,
		},
	},
})
