return {
	-- nvim-autopairs --
	-- add pair quotes / parenthesis
	-- 自动配对括号
	{
		"windwp/nvim-autopairs",
		config = function()
			require("config.enhancement.pairs.autopairs")
		end,
	},

	-- mini.surround --
	-- manager pair within operator mode
	-- 使用等待模式优化括号对的管理
	{
		"nvim-mini/mini.surround",
		config = function()
			require("config.enhancement.pairs.surround")
		end,
	},

	-- sentiment.nvim --
	-- pairs highlights
	-- 括号对高亮
	{
		"utilyre/sentiment.nvim",
		event = "VeryLazy",
		init = function()
			require("config.enhancement.pairs.pair-hl").setup()
		end,
		config = function()
			require("config.enhancement.pairs.pair-hl").load_sentiment()
		end,
	},

	-- nvim-treesitter-textobjects --
	-- textobjects by treesitter
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = "VeryLazy",
		config = function()
			require("config.enhancement.pairs.textobjects")
		end,
	},
}
