require("mason").setup({
	-- github = {
	-- 	download_url_template = "git@github.com:%s/releases/download/%s/%s",
	-- },
})

require("mason-lspconfig").setup({
	ensure_installed = {
		-- LSP Servers
		"clangd",
		-- "jdtls",
		"lua_ls",
		"eslint",
		"marksman",
		"pyright",
		"bashls",
		"ruff",
		"stylua",
		"gopls",
	},
	automatic_installation = true,
})

local on_attach = function(_, bufnr)
	local opts = { buffer = bufnr, noremap = true, silent = true }

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

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
	settings = {
		wiki = {
			style = "file-stem",
		},
	},
	single_file_support = true,
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
	"java-debug-adapter",
	"java-test",
	"delve",
	-- Linters
	"checkstyle",
	"luacheck",
	"markdownlint",
	"proselint",
	"shellcheck",
	"golangci-lint",
	-- Formatters
	"stylua",
	"prettier",
	"prettierd",
	"shfmt",
	"autopep8",
	"black",
	"shfmt",
	"goimports",
}
for _, tool_name in ipairs(other_tools) do
	local tool = registry.get_package(tool_name)
	if not tool:is_installed() then
		tool:install():once("closed", function()
			print("[Mason] Successfully installed: " .. tool_name)
		end)
	end
end
