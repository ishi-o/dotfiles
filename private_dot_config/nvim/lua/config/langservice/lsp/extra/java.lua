require("java").setup()
local conf = require("config.langservice.lsp.conf")
vim.lsp.config("jdtls", {
	on_attach = function(client, buf)
		conf.on_attach(client, buf)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
	capabilities = conf.capabilities,
	settings = {
		java = {
			signatureHelp = { enabled = true },
			inlayHints = { enabled = false },
		},
	},
})
-- NOTE: `editor.action.triggerParameterHints` is a VSCode client method
-- due to settings.java.signatureHelp.enabled=true
-- when using completion in a java file, the following error occurs:
-- > method "workspace/executeClientCommand":
-- > either a result or an error must be sent to the server in response
-- However, it caused an issue where the spring-boot LS could not start normally
-- see https://github.com/nvim-java/nvim-java/issues/399#issuecomment-3678627120
--     https://github.com/nvim-java/nvim-java/issues/399#issuecomment-3678667874
local orig_handler = vim.lsp.handlers["workspace/executeClientCommand"]
vim.lsp.handlers["workspace/executeClientCommand"] = function(...)
	local _, params, ctx, _ = ...
	local client = vim.lsp.get_client_by_id(ctx.client_id)
	if client and params.command == "editor.action.triggerParameterHints" and client.name == "jdtls" then
		vim.lsp.buf.signature_help()
		return true
	end
	return orig_handler(...)
end
vim.lsp.enable("jdtls")
