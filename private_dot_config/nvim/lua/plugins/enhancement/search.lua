return {
	-- telescope.nvim --
	-- file search
	-- 跨文件模糊搜索
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},
		config = function()
			require("config.enhancement.search.telescope")
		end,
	},
	-- flash.nvim --
	-- inner search
	-- 窗口内快速跳转
	{
		"folke/flash.nvim",
		lazy = false,
		event = "VeryLazy",
		config = function()
			require("config.enhancement.search.flash")
		end,
	},
}
