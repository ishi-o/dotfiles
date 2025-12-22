local M = {}

local map = vim.keymap.set

M.on_attach = function(client, bufnr)
	-- map("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
	-- map("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr })
	-- map("n", "gr", vim.lsp.buf.references, { buffer = bufnr })
	-- map("n", "gy", vim.lsp.buf.type_definition, { buffer = bufnr })
	-- map("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr })
	map("n", "K", function()
		vim.lsp.buf.hover({
			border = "single",
		})
	end, { buffer = bufnr })
	map("n", "gK", function()
		vim.lsp.buf.signature_help({
			border = "single",
		})
	end, { buffer = bufnr })
	-- map("n", "gs", vim.lsp.buf.document_symbol, { buffer = bufnr })
	-- map("n", "gai", vim.lsp.buf.incoming_calls, { buffer = bufnr })
	-- map("n", "gao", vim.lsp.buf.outgoing_calls, { buffer = bufnr })
	map("n", "<F2>", vim.lsp.buf.rename, { buffer = bufnr })
	map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
	map("n", "<leader>cr", vim.lsp.buf.rename, { buffer = bufnr })
	map("n", "<leader>C", vim.lsp.buf.code_action, { buffer = bufnr })
	map("n", "<leader>cc", vim.lsp.buf.code_action, { buffer = bufnr })

	if client.server_capabilities.documentSymbolProvider then
		require("nvim-navic").attach(client, bufnr)
	end

	-- FIX: jdtls inlay hints
	-- if client:supports_method("textDocument/inlayHint") or client.name == "jdtls" then
	if client:supports_method("textDocument/inlayHint") then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end

	vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
		callback = vim.lsp.codelens.refresh,
	})
end

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
M.capabilities = require("blink.cmp").get_lsp_capabilities()
-- M.capabilities = {}

return M
