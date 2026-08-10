require("mason").setup({})
local conf = require("config.langs.lsp.conf")
local registry = require("mason-registry")

local tools = {
	-- LSP Servers
	"bash-language-server",
	"buf",
	"clangd",
	"css-lsp",
	"docker-compose-language-service",
	"dockerfile-language-server",
	"gopls",
	"groovy-language-server",
	"helm-ls",
	"html-lsp",
	"jdtls",
	"java-test",
	"json-lsp",
	"lemminx",
	"lua-language-server",
	"marksman",
	"nginx-language-server",
	"ruff",
	"rust-analyzer",
	"taplo",
	"texlab",
	"tinymist",
	"typescript-language-server",
	"ty",
	"typos-lsp",
	"vtsls",
	"vue-language-server",
	"yaml-language-server",
	-- Linters
	"cpplint",
	"eslint_d",
	"hadolint",
	"htmlhint",
	"golangci-lint",
	"jsonlint",
	"shellcheck",
	"stylelint",
	-- Formatters
	"clang-format",
	"gofumpt",
	"goimports",
	"gomodifytags",
	"impl", -- go: generates method stubs for implementing an interface
	"jq",
	"nginx-config-formatter",
	"prettier",
	"prettierd",
	"shfmt",
	"typstyle",
}

for _, package_name in ipairs(tools) do
	if not registry.has_package(package_name) then
		vim.notify("[Mason] Package not found: " .. package_name, vim.log.levels.WARN)
	else
		local package = registry.get_package(package_name)
		if not package:is_installed() then
			package:install():once("closed", function()
				print("[Mason] Successfully installed: " .. package_name)
			end)
		end
	end
end

local simple_servers = {
	"clangd",
	"cssls",
	"dockerls",
	"docker_compose_language_service",
	"groovyls",
	"helm_ls",
	"html",
	"marksman",
	"nginx_language_server",
	"rust_analyzer",
	"taplo",
	"texlab",
}
for _, server in ipairs(simple_servers) do
	vim.lsp.config(server, {
		on_attach = conf.on_attach,
		capabilities = conf.capabilities,
	})
	vim.lsp.enable(server)
end

local custom_confs = {
	{ module = "bash",      servers = { "bashls" } },
	{ module = "go",        servers = { "gopls" } },
	{ module = "java",      servers = { "jdtls" } },
	{ module = "js-family", servers = { "ts_ls", "jsonls" } },
	{ module = "lua",       servers = { "lua_ls" } },
	{ module = "protobuf",  servers = { "buf_ls" } },
	{ module = "python",    servers = { "ty" } },
	{ module = "typos",     servers = { "typos_lsp" } },
	{ module = "vue",       servers = { "vtsls", "vue_ls" } },
	{ module = "xml",       servers = { "lemminx" } },
	{ module = "yaml",      servers = { "yamlls" } },
}
for _, item in ipairs(custom_confs) do
	require("config.langs.lsp.config." .. item.module)
	for _, server in ipairs(item.servers) do
		vim.lsp.enable(server)
	end
end
