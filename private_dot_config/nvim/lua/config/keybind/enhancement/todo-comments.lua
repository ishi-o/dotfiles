-- todo-comments --
return {
	-- todo-comments.nvim --
	{
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
		{ "<leader>xt", "<cmd>TodoTrouble toggle<CR>", desc = "Todo (Trouble)" },
		{
			"<leader>xT",
			"<cmd>TodoTrouble toggle filter = {tag = {TODO,FIX,FIXME}}<CR>",
			desc = "Todo/Fix/Fixme (Trouble)",
		},
		{ "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "Todo" },
		{ "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<CR>", desc = "Todo/Fix/Fixme" },
	},
}
