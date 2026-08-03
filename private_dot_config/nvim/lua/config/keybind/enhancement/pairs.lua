return {
	{
		cond = function()
			return _G.plugin_installed("mini.surround")
		end,
		{ "gsa", desc = "Add Surrounding", mode = { "n", "x" } },
		{ "gsd", desc = "Delete Surrounding" },
		{ "gsf", desc = "Find Right Surrounding" },
		{ "gsF", desc = "Find Left Surrounding" },
		{ "gsh", desc = "Highlight Surrounding" },
		{ "gsr", desc = "Replace Surrounding" },
		{ "gsn", desc = "Update `MiniSurround.config.n_lines`" },
	},
	{
		cond = function()
			return _G.plugin_installed("nvim-treesitter-textobjects")
		end,
		{
			"am",
			'<cmd>lua require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")<CR>',
			mode = { "x", "o" },
			desc = "Around method",
		},
		{
			"im",
			'<cmd>lua require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")<CR>',
			mode = { "x", "o" },
			desc = "Inner method",
		},
		{
			"ac",
			'<cmd>lua require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")<CR>',
			mode = { "x", "o" },
			desc = "Around class",
		},
		{
			"ic",
			'<cmd>lua require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")<CR>',
			mode = { "x", "o" },
			desc = "Inner class",
		},
		{
			"]m",
			'<cmd>lua require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")<CR>',
			mode = { "n", "x", "o" },
			desc = "Next method start",
		},
		{
			"]o",
			'<cmd>lua require("nvim-treesitter-textobjects.move").goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")<CR>',
			mode = { "n", "x", "o" },
			desc = "Next loop start",
		},
		{
			"]z",
			'<cmd>lua require("nvim-treesitter-textobjects.move").goto_next_start("@fold", "folds")<CR>',
			mode = { "n", "x", "o" },
			desc = "Next fold",
		},
		{
			"]M",
			'<cmd>lua require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")<CR>',
			mode = { "n", "x", "o" },
			desc = "Next method end",
		},
		{
			"[m",
			'<cmd>lua require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")<CR>',
			mode = { "n", "x", "o" },
			desc = "Prev method start",
		},
		{
			"[M",
			'<cmd>lua require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")<CR>',
			mode = { "n", "x", "o" },
			desc = "",
		},
		{
			"]d",
			'<cmd>lua require("nvim-treesitter-textobjects.move").goto_next("@conditional.outer", "textobjects")<CR>',
			mode = { "n", "x", "o" },
			desc = "Next condition stmt",
		},
		{
			"[d",
			'<cmd>lua require("nvim-treesitter-textobjects.move").goto_previous("@conditional.outer", "textobjects")<CR>',
			mode = { "n", "x", "o" },
			desc = "Prev condition stmt",
		},
	},
}
