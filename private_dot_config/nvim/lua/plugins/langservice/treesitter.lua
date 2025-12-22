return {
	-- nvim-treesitter --
	-- syntax highlight
	-- 语法高亮支持
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		version = false,
		build = ":TSUpdate",
		config = function()
			require("config.langservice.treesitter")
		end,
	},
	-- TODO: add windwp/nvim-ts-autotag
}
