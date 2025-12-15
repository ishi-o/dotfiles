-- outline --
return {
	-- Aerial.nvim --
	{
		{ "<leader>o", "<cmd>AerialToggle<CR>", desc = "Toggle: outline (Symbols)" },
		{ "[s", "<cmd>" .. vim.v.count1 .. "AerialPrev<CR>", desc = "Goto: prev symbol" },
		{ "]s", "<cmd>" .. vim.v.count1 .. "AerialNext<CR>", desc = "Goto: next symbol" },
		{ "]S", "<cmd>" .. vim.v.count1 .. "AerialPrev<CR>", desc = "Goto: prev symbol" },
		{ "[S", "<cmd>" .. vim.v.count1 .. "AerialNext<CR>", desc = "Goto: next symbol" },
	},

	-- trouble.nvim --
	{
		"<leader>xs",
		"<cmd>Trouble symbols toggle focus=false<CR>",
		desc = "Toggle: symbols (Trouble)",
	},
}
