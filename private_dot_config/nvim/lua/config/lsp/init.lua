require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		-- LSP Servers
		"bashls",
		"clangd",
		-- "jdtls",
		"lua_ls",
		"eslint",
		"gopls",
		"marksman",
		-- "pyright",
		"ty",
		"ruff",
		"sqlls",
		"sqls",
		"stylua",
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
	"cpplint",
	"checkstyle",
	"golangci-lint",
	"luacheck",
	"markdownlint",
	"proselint",
	"shellcheck",
	-- Formatters
	-- "autopep8",
	-- "black",
	"clang-format",
	"goimports",
	"prettier",
	"prettierd",
	"shfmt",
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
