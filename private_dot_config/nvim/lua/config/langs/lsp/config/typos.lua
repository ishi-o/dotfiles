local conf = require("config.langs.lsp.conf")
vim.lsp.config("typos_lsp", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
	root_dir = function(bufnr, on_dir)
		if vim.bo[bufnr].filetype ~= "bigfile" then
			on_dir(vim.fn.getcwd())
		end
	end,
})
