local conf = require("config.dev.lsp.conf")

vim.lsp.config("lemminx", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
	filetypes = {
		"xml",
		"xsd",
		"xsl",
		"xslt",
		"svg" --[[ , "jproperties" ]],
	},
})
