require("java").setup()
local conf = require("config.langservice.lsp.conf")
vim.lsp.config("jdtls", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
	settings = {
		-- signatureHelp and inlayHints is enabled by default
		java = {},
	},
})
-- NOTE: `editor.action.triggerParameterHints` is a VSCode client method
-- due to settings.java.signatureHelp.enabled=true
-- when using completion in a java file, the following error occurs:
-- > method "workspace/executeClientCommand":
-- > either a result or an error must be sent to the server in response
-- However, it caused an issue where the spring-boot LS could not start normally
-- see https://github.com/nvim-java/nvim-java/issues/399#issuecomment-3678627120
local f = vim.lsp.handlers["workspace/executeClientCommand"]
vim.lsp.handlers["workspace/executeClientCommand"] = function(err, result, ctx, config)
	f(err, result, ctx, config)
	return true
end
vim.lsp.enable("jdtls")
