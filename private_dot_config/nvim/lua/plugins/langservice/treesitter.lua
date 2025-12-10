return {
	-- nvim-treesitter --
	-- syntax highlight
	-- 语法高亮支持
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		build = ":TSUpdate",
		config = function()
			require("config.langservice.treesitter")
		end,
	},
}
