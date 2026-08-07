local conf = require("config.langs.treesitter_conf")
local autocmd = _G.UserUtils.autocmd
require("nvim-treesitter").install(conf.fts)

autocmd("FileType", {
	pattern = conf.fts,
	callback = function()
		vim.treesitter.start()
	end,
})
