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

	-- NOTE: `editor.action.triggerParameterHints` is a VSCode client method
	-- due to settings.java.signatureHelp.enabled=true
	-- when using completion in a java file, the following error occurs:
	-- > method "workspace/executeClientCommand":
	-- > either a result or an error must be sent to the server in response
	-- However, it caused an issue where the spring-boot LS could not start normally
	-- see https://github.com/nvim-java/nvim-java/issues/399#issuecomment-3678627120
	--     https://github.com/nvim-java/nvim-java/issues/399#issuecomment-3678667874
	local orig_handler_executeClientCommand = vim.lsp.handlers["workspace/executeClientCommand"]
	vim.lsp.handlers["workspace/executeClientCommand"] = function(...)
		local _, params, ctx, _ = ...
		local client = vim.lsp.get_client_by_id(ctx.client_id)
		if client and params.command == "editor.action.triggerParameterHints" and client.name == "jdtls" then
			vim.lsp.buf.signature_help()
			return true
		end
		return orig_handler_executeClientCommand(...)
	end

	local orig_handler_publishDiagnostics = vim.lsp.handlers["textDocument/publishDiagnostics"]
	vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
		if result and result.diagnostics then
			local seen = {}
			local unique = {}
			for _, diag in ipairs(result.diagnostics) do
				if not string.find(diag.message, "Duplicate annotation") then
					local key =
						string.format("%d:%d:%s", diag.range.start.line, diag.range.start.character, diag.message)
					if not seen[key] then
						seen[key] = true
						table.insert(unique, diag)
					end
				end
			end
			result.diagnostics = unique
		end
		orig_handler_publishDiagnostics(err, result, ctx, config)
	end

	-- FIX: jdtls inlay hints
	-- if client:supports_method("textDocument/inlayHint") or client.name == "jdtls" then
	if client:supports_method("textDocument/inlayHint") and client.name ~= "jdtls" then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end

	vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
		callback = vim.lsp.codelens.refresh,
	})
end

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
local ok, blink = pcall(require, "blink.cmp")
if ok then
	M.capabilities = blink.get_lsp_capabilities()
else
	M.capabilities = {}
end
-- M.capabilities = {}

return M
