return {
	-- Comment.nvim --
	-- add comment
	-- 注释支持
	{
		"numToStr/Comment.nvim",
		config = function()
			require("config.langservice.comment.comment")
		end,
	},

	-- neogen --
	-- add document smartly
	-- 文档型注释支持
	{
		"danymat/neogen",
		lazy = true,
		module = "neogen",
		cmd = "Neogen",
		config = function()
			require("config.langservice.comment.document")
		end,
	},
}
