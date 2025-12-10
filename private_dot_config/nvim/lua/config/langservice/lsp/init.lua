require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		-- LSP Servers
		"bashls",
		"clangd",
		"cssls",
		"dockerls",
		"docker_compose_language_service",
		"html",
		"lua_ls",
		-- "eslint",
		"gopls",
		-- "jdtls",
		"jsonls",
		"marksman",
		"nginx_language_server",
		-- "pyright",
		"taplo",
		"tinymist",
		"ts_ls",
		"ty",
		"ruff",
		"rust_analyzer",
		"sqlls",
		"sqls",
		"stylua",
		"texlab",
		"yamlls",
	},
	automatic_installation = true,
})

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
	"goimports",
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
	"xmlformatter",
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

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = false,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
	},
})

require("config.langservice.lsp.config.c-cpp")
require("config.langservice.lsp.config.css")
require("config.langservice.lsp.config.dockerfile")
require("config.langservice.lsp.config.go")
require("config.langservice.lsp.config.html")
require("config.langservice.lsp.config.java")
require("config.langservice.lsp.config.js-family")
require("config.langservice.lsp.config.lua")
require("config.langservice.lsp.config.markdown")
require("config.langservice.lsp.config.nginx")
require("config.langservice.lsp.config.python")
require("config.langservice.lsp.config.rust")
require("config.langservice.lsp.config.sh")
require("config.langservice.lsp.config.sql")
require("config.langservice.lsp.config.tex")
require("config.langservice.lsp.config.toml")
require("config.langservice.lsp.config.xml")
require("config.langservice.lsp.config.yaml")
