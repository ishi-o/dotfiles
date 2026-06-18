return {
	{
		{
			"<leader><tab><tab>",
			function()
				vim.api.nvim_feedkeys(":", "n", false)
				vim.defer_fn(function()
					vim.api.nvim_feedkeys("tabnew ", "n", false)
				end, 50)
			end,
			desc = "NewTab (input filename)",
		},
		{ "[<tab>", "<cmd>tabprevious<CR>", desc = "Previous tab" },
		{ "]<tab>", "<cmd>tabnext<CR>", desc = "Next tab" },
		{ "<leader><tab>d", "<cmd>tabc<CR>", desc = "Delete tab" },
		{
			"<leader><tab>r",
			function()
				vim.api.nvim_feedkeys(":", "n", false)
				vim.defer_fn(function()
					vim.api.nvim_feedkeys("BufferlineTabRename", "n", false)
				end, 50)
			end,
			desc = "Rename",
		},
	},
}
