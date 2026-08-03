return {
	{
		"numToStr/Comment.nvim",
		config = function()
			require("config.langs.comment.comment")
		end,
	},
	{
		"danymat/neogen",
		lazy = true,
		module = "neogen",
		cmd = "Neogen",
		config = function()
			require("config.langs.comment.document")
		end,
	},
}
