return {
	{
		"folke/todo-comments.nvim",
		lazy = true,
		cmd = { "TodoTrouble", "TodoTelescope" },
		config = function()
			require("todo-comments").setup()
		end,
	},
}
