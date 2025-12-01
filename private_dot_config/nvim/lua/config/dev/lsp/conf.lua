local M = {}

local map = vim.keymap.set

M.on_attach = function(client, bufnr)
	map("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "[G]o to [D]efinition" })
	map("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "[G]o to [I]mplementation" })
	map("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "[G]o to [R]eference" })
	map("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Show documentation" })
	map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "[R]e[n]ame" })
	map("n", "<leader>C", vim.lsp.buf.code_action, { buffer = bufnr, desc = "[C]ode actions" })

	if client.server_capabilities.documentSymbolProvider then
		require("nvim-navic").attach(client, bufnr)
	end

	if client:supports_method("textDocument/inlayHint") or client.name == "jdtls" then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end
end

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
M.capabilities = require("blink.cmp").get_lsp_capabilities()
-- M.capabilities = {}

return M
