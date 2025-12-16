-- misc --
return {
	-- change mode --
	{
		-- Using <C-c> in insert mode breaks neo-tree
		{ "jj", "<Esc>", mode = "i", desc = "Return to normal mode" },
		-- <Esc> in command mode has some issues
		{ "jj", "<C-c>", mode = "c", desc = "Return to normal mode" },
	},

	-- save --
	{ "<leader>w", "<cmd>w<CR>", desc = "Save file" },

	-- quit --
	{ "<leader>z", "<cmd>qa<CR>", desc = "Quit neovim" },
	{ "z<leader>", "<cmd>qa<CR>", desc = "Quit neovim" },

	-- move line --
	-- now use mini-move
	-- config: ~/.config/nvim/lua/config/enhancement/move.lua
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
