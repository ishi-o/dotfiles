return {
	{
		cond = function()
			return _G.UserUtils.plugin_installed("todo-comments.nvim")
		end,
		{
			"]t",
			'<cmd>lua require("todo-comments").jump_next()<CR>',
			desc = "Next Todo Comment",
		},
		{
			"[t",
			'<cmd>lua require("todo-comments").jump_prev()<CR>',
			desc = "Previous Todo Comment",
		},
		{
			"<leader>ft",
			function()
				require("lazy").load({ plugins = { "todo-comments.nvim" } })
				Snacks.picker.todo_comments()
			end,
			desc = "Todo",
		},
		{
			"<leader>fT",
			function()
				require("lazy").load({ plugins = { "todo-comments.nvim" } })
				Snacks.picker.todo_comments({
					keywords = { "TODO", "FIX", "FIXME" },
				})
			end,
			desc = "Todo/Fix/Fixme",
		},
	},
}
