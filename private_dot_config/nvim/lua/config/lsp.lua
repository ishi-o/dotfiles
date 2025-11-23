local map = vim.keymap.set

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
		"pyright",
		"ruff",
		"stylua",
	},
	automatic_installation = true,
})

local on_attach = function(client, bufnr)
	map("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "[G]o to [D]efinition" })
	map("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "[G]o to [I]mplementation" })
	map("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "[G]o to [R]eference" })
	map("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Show documentation" })
	map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "[R]e[n]ame" })
	map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "[C]ode [A]ctions" })

	if client.server_capabilities.documentSymbolProvider then
		require("nvim-navic").attach(client, bufnr)
	end
end

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
local capabilities = require("blink.cmp").get_lsp_capabilities()

local lsp_config = vim.lsp.config

lsp_config("lua_ls", {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					[vim.fn.stdpath("config")] = true,
				},
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

lsp_config("marksman", {
	on_attach = on_attach,
	capabilities = capabilities,
})

lsp_config("clangd", {
	on_attach = on_attach,
	capabilities = capabilities,
})

lsp_config("gopls", {
	on_attach = on_attach,
	capabilities = capabilities,
})

lsp_config("eslint", {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		eslint = {
			enable = true,
			validate = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
		},
	},
})

lsp_config("bashls", {
	on_attach = on_attach,
	capabilities = capabilities,
})

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
	"golangci-lint",
	"luacheck",
	"markdownlint",
	"proselint",
	"shellcheck",
	-- Formatters
	"autopep8",
	"black",
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
