require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		-- LSP Servers
		"bashls",
		"buf_ls",
		"clangd",
		"cssls",
		"dockerls",
		"docker_compose_language_service",
		"helm_ls",
		"html",
		"lemminx",
		"lua_ls",
		-- "eslint",
		"gopls",
		-- "gradle_ls",
		"groovyls",
		"jdtls",
		"jsonls",
		"marksman",
		-- "nginx_language_server",
		-- "pyright",
		"taplo",
		-- "thirftls",
		"tinymist",
		"ts_ls",
		"ty",
		"typos_lsp",
		"ruff",
		"rust_analyzer",
		-- "sqlls",
		-- "sqls",
		"stylua",
		"texlab",
		"vtsls",
		"vue_ls",
		"yamlls",
	},
	automatic_installation = true,
})

local conf = require("config.langs.lsp.conf")
local registry = require("mason-registry")
local other_tools = {
	-- DAPs
	"codelldb",
	"debugpy",
	"delve",
	"java-debug-adapter",
	"java-test",
	-- Linters
	"checkstyle",
	"cpplint",
	"eslint_d",
	"hadolint",
	"htmlhint",
	"golangci-lint",
	"jsonlint",
	"luacheck",
	"markdownlint-cli2",
	"proselint",
	"shellcheck",
	-- "sqruff",
	"stylelint",
	"yamllint",
	-- Formatters
	-- "autopep8",
	-- "black",
	"clang-format",
	"gofumpt",
	"goimports",
	"gomodifytags",
	"impl", -- go: generates method stubs for implementing an interface
	"jq",
	"markdown-toc",
	"nginx-config-formatter",
	"prettier",
	"prettierd",
	"rustfmt",
	"shfmt",
	"sqlfluff",
	-- "sql-formatter",
	"typstyle",
	-- "yamlfmt",
}
for _, tool_name in ipairs(other_tools) do
	local tool = registry.get_package(tool_name)
	if not tool:is_installed() then
		tool:install():once("closed", function()
			print("[Mason] Successfully installed: " .. tool_name)
		end)
	end
end

local simple_servers = {
	"bashls",
	"clangd",
	"cssls",
	"dockerls",
	"docker_compose_language_service",
	-- "gradle_ls",
	"groovyls",
	"helm_ls",
	"html",
	"marksman",
	"nginx_language_server",
	"rust_analyzer",
	"taplo",
	"texlab",
	"typos_lsp",
}
for _, server in ipairs(simple_servers) do
	vim.lsp.config(server, {
		on_attach = conf.on_attach,
		capabilities = conf.capabilities,
	})
	vim.lsp.enable(server)
end

local custom_confs = {
	{ module = "go", servers = { "gopls" } },
	{ module = "java", servers = { "jdtls" } },
	{ module = "js-family", servers = { "ts_ls", "jsonls" } },
	{ module = "lua", servers = { "lua_ls" } },
	{ module = "protobuf", servers = { "buf_ls" } },
	{ module = "python", servers = { "ty" } },
	{ module = "vue", servers = { "vtsls", "vue_ls" } },
	{ module = "xml", servers = { "lemminx" } },
	{ module = "yaml", servers = { "yamlls" } },
}
for _, item in ipairs(custom_confs) do
	require("config.langs.lsp.config." .. item.module)
	for _, server in ipairs(item.servers) do
		vim.lsp.enable(server)
	end
end
