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
		"jdtls",
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
		-- "sqlls",
		-- "sqls",
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

local confs = {
	"c-cpp",
	"css",
	"dockerfile",
	"go",
	"html",
	"java",
	"js-family",
	"lua",
	"markdown",
	"nginx",
	"python",
	"rust",
	"sh",
	"sql",
	"tex",
	"toml",
	"xml",
	"yaml",
}
for _, conf in ipairs(confs) do
	require("config.langservice.lsp.config." .. conf)
end
