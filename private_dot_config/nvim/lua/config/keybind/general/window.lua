-- window --
return {
	-- window locally --
	{
		{
			"<leader>V",
			function()
				vim.api.nvim_feedkeys(":", "n", false)
				vim.defer_fn(function()
					vim.api.nvim_feedkeys("split ", "n", false)
				end, 50)
			end,
			desc = "Horizontal Split (input filename)",
		},
		{
			"<leader>v",
			function()
				vim.api.nvim_feedkeys(":", "n", false)
				vim.defer_fn(function()
					vim.api.nvim_feedkeys("vsplit ", "n", false)
				end, 50)
			end,
			desc = "Vertical Split (input filename)",
		},
		{ "<leader>-", "<cmd>split<CR>", desc = "Horizontal Split" },
		{ "<leader>|", "<cmd>vsplit<CR>", desc = "Vertical Split" },
		{ "<leader>wd", "<cmd>close<CR>", desc = "Delete window" },
		{ "<leader>q", "<cmd>close<CR>", desc = "Delete window" },
		-- window switch --
		{ "<leader>h", "<cmd>wincmd h<CR>", desc = "Focus on the left page", hidden = true },
		{ "<leader>j", "<cmd>wincmd j<CR>", desc = "Focus on the page below", hidden = true },
		{ "<leader>k", "<cmd>wincmd k<CR>", desc = "Focus on the page above", hidden = true },
		{ "<leader>l", "<cmd>wincmd l<CR>", desc = "Focus on the right page", hidden = true },
	},

	-- window enhancement --
	{
		-- window resize --
		{ "<A-h>", '<cmd>lua require("smart-splits").resize_left()<CR>', desc = "Window resize left" },
		{ "<A-j>", '<cmd>lua require("smart-splits").resize_down()<CR>', desc = "Window resize down" },
		{ "<A-k>", '<cmd>lua require("smart-splits").resize_up()<CR>', desc = "Window resize up" },
		{ "<A-l>", '<cmd>lua require("smart-splits").resize_right()<CR>', desc = "Window resize right" },
		-- window swap --
		{
			"<leader>H",
			'<cmd>lua require("smart-splits").swap_buf_left()<CR>',
			desc = "Window swap left",
			hidden = true,
		},
		{
			"<leader>J",
			'<cmd>lua require("smart-splits").swap_buf_down()<CR>',
			desc = "Window swap down",
			hidden = true,
		},
		{ "<leader>K", '<cmd>lua require("smart-splits").swap_buf_up()<CR>', desc = "Window swap up", hidden = true },
		{
			"<leader>L",
			'<cmd>lua require("smart-splits").swap_buf_right()<CR>',
			desc = "Window swap right",
			hidden = true,
		},
	},
}
