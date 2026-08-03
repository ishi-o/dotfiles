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
		local ok, navic = pcall(require, "nvim-navic")
		if ok then
			navic.attach(client, bufnr)
		end
	end

	if client:supports_method("textDocument/inlayHint") then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end

	if client:supports_method("textDocument/codeLens") then
		vim.lsp.codelens.enable(true, { bufnr = bufnr })
	end
end

local ok, blink = pcall(require, "blink.cmp")
if ok then
	M.capabilities = blink.get_lsp_capabilities()
else
	M.capabilities = {}
end

return M
