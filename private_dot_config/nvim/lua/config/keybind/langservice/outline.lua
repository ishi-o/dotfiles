-- outline --
return {
	-- aerial.nvim --
	{
		{ "<leader>o", "<cmd>AerialToggle<CR>", desc = "Toggle: outline (Symbols)" },
		{
			"[s",
			function()
				vim.cmd(vim.v.count1 .. "AerialPrev")
			end,
			desc = "Goto: prev symbol",
		},
		{
			"]s",
			function()
				vim.cmd(vim.v.count1 .. "AerialNext")
			end,
			desc = "Goto: next symbol",
		},
		{
			"]S",
			function()
				vim.cmd(vim.v.count1 .. "AerialPrev")
			end,
			desc = "Goto: prev symbol",
		},
		{
			"[S",
			function()
				vim.cmd(vim.v.count1 .. "AerialNext")
			end,
			desc = "Goto: next symbol",
		},
		{
			"(",
			function()
				vim.cmd(vim.v.count1 .. "AerialPrev")
			end,
			desc = "Goto: prev symbol",
		},
		{
			")",
			function()
				vim.cmd(vim.v.count1 .. "AerialNext")
			end,
			desc = "Goto: next symbol",
		},
	},

	-- trouble.nvim --
	{
		"<leader>xs",
		"<cmd>Trouble symbols toggle focus=false<CR>",
		desc = "Toggle: symbols (Trouble)",
	},
}
