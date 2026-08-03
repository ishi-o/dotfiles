local conf = require("config.langs.treesitter_conf")
require("nvim-treesitter").install(conf.fts)

vim.api.nvim_create_autocmd("FileType", {
	pattern = conf.fts,
	callback = function()
		vim.treesitter.start()
	end,
})
