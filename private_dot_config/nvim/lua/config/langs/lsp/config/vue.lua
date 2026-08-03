local conf = require("config.langs.lsp.conf")
local mason_registry = require("mason-registry")

local mason_path = vim.fn.stdpath("data") .. "/mason"
local vue_path = mason_path .. "/packages/vue-language-server/node_modules/@vue/language-server"

vim.lsp.config("vtsls", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
	filetypes = { "vue" },
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					{
						name = "@vue/typescript-plugin",
						location = vue_path,
						languages = { "vue" },
						configNamespace = "typescript",
					},
				},
			},
		},
	},
})

vim.lsp.config("vue_ls", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
	filetypes = { "vue" },
	init_options = {
		hybridMode = true,
	},
})
