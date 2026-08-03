return {
	{
		cond = function()
			return _G.plugin_installed("dial.nvim")
		end,
		{
			"<C-a>",
			'<cmd>lua require("dial.map").manipulate("increment", "normal")<CR>',
			desc = "Increment constants",
		},
		{
			"<C-x>",
			'<cmd>lua require("dial.map").manipulate("decrement", "normal")<CR>',
			desc = "Decrement constants",
		},
		{
			"g<C-a>",
			'<cmd>lua require("dial.map").manipulate("increment", "gnormal")<CR>',
			desc = "Sequence Increment constants",
		},
		{
			"g<C-x>",
			'<cmd>lua require("dial.map").manipulate("decrement", "gnormal")<CR>',
			desc = "Sequence Decrement constants",
		},
		{
			"<C-a>",
			'<cmd>lua require("dial.map").manipulate("increment", "visual")<CR>',
			mode = "x",
			desc = "Increment constants",
		},
		{
			"<C-x>",
			'<cmd>lua require("dial.map").manipulate("decrement", "visual")<CR>',
			mode = "x",
			desc = "Decrement constants",
		},
		{
			"g<C-a>",
			'<cmd>lua require("dial.map").manipulate("increment", "gvisual")<CR>',
			mode = "x",
			desc = "Sequence Increment constants",
		},
		{
			"g<C-x>",
			'<cmd>lua require("dial.map").manipulate("decrement", "gvisual")<CR>',
			mode = "x",
			desc = "Sequence Decrement constants",
		},
	},
}
