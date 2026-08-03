return {
	{ "jj", "<Esc>", mode = "i", desc = "Return to normal mode" },
	{ "jj", "<C-c>", mode = "c", desc = "Return to normal mode" },
	{ "<leader>w", "<cmd>w<CR>", desc = "Save file" },
	{ "<leader>z", "<cmd>qa<CR>", desc = "Quit neovim" },
	{ "z<leader>", "<cmd>qa<CR>", desc = "Quit neovim" },
	{
		{
			"<C-j>",
			desc = "Move line down",
		},
		{
			"<C-k>",
			desc = "Move line up",
		},
		{
			"<C-j>",
			mode = "x",
			desc = "Move selected lines down",
		},
		{
			"<C-k>",
			mode = "x",
			desc = "Move selected lines up",
		},
	},
}
