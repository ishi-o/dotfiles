return {
	-- snacks.nvim --
	-- dashboard, indent, bigfile, explorer
	-- picker, input, scope, scroll, words
	-- 首页, 缩进, 大文件优化, 文件树
	-- 模糊选择, 输入优化, 作用域选取, 滚动优化, 变量选取
	{
		"folke/snacks.nvim",
		priority = 1000,
		config = function()
			require("config.ui.snacks")
		end,
	},
}
