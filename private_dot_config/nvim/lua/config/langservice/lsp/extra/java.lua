require("java").setup()
local conf = require("config.langservice.lsp.conf")
vim.lsp.config("jdtls", {
	on_attach = function(client, bufnr)
		conf.on_attach(client, bufnr)
		-- NOTE:
		-- due to settings.java.signatureHelp.enabled=true
		-- when using completion in a java file, the following error occurs:
		-- method "workspace/executeClientCommand":
		-- either a result or an error must be sent to the server in response
		-- therefore let handlers["workspace/executeClientCommand"] return vim.NIL
		-- see https://github.com/nvim-java/nvim-java/issues/399#issuecomment-3677412515
		client.handlers["workspace/executeClientCommand"] = function(_, _, _, _)
			return vim.NIL
		end
	end,
	capabilities = conf.capabilities,
	settings = {
		java = {
			inlayHints = {
				parameterNames = {
					enabled = "all",
				},
			},
			signatureHelp = { enabled = true },
		},
	},
})
vim.lsp.enable("jdtls")
