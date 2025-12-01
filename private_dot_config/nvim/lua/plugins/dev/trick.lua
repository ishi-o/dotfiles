return {
	-- autopairs --
	-- add pair quotes / parenthesis
	{
		"windwp/nvim-autopairs",
		config = function()
			require("config.dev.trick.autopairs")
		end,
	},
	-- comment --
	-- add comment
	{
		"numToStr/Comment.nvim",
		config = function()
			require("config.dev.trick.comment")
		end,
	},
	-- dial --
	-- constant inc/dec
	{
		"monaqa/dial.nvim",
		config = function()
			require("config.dev.trick.dial")
		end,
	},
	-- conform --
	-- formatOnSave
	{
		"stevearc/conform.nvim",
		config = function()
			require("config.dev.trick.conform")
		end,
	},
}
