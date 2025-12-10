return {
	{
		"folke/todo-comments.nvim",
		lazy = true,
		cmd = { "TodoTrouble", "TodoTelescope" },
		config = function()
			require("config.enhancement.todo-comments")
		end,
	},
}
