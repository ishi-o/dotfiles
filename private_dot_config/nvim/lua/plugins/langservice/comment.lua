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
