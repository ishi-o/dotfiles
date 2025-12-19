-- search --
return {
	-- telescope --
	-- now we use snacks.picker
	-- {
	-- { "<leader>fd", require("telescope.builtin").find_files, desc = "Find Files" },
	-- { "<leader>fg", require("telescope.builtin").live_grep, desc = "Grep" },
	-- { "<leader>fb", require("telescope.builtin").buffers, desc = "Buffers" },
	-- { "<leader>fr", require("telescope.builtin").oldfiles, desc = "Recent" },
	-- { "<leader>fe", "<cmd>Telescope file_browser<CR>", desc = "File explorer" },
	-- { "?", require("telescope.builtin").help_tags, desc = "Telescope help tags" },
	-- },

	-- flash --
	{
		{
			"s",
			function()
				require("flash").jump()
			end,
			mode = { "n", "x", "o" },
			desc = "Search and jump",
		},
		{
			"S",
			function()
				require("flash").treesitter()
			end,
			mode = { "n", "x", "o" },
			desc = "Search block by treesitter",
		},
		{
			"r",
			function()
				require("flash").remote()
			end,
			mode = "o",
			desc = "Remote operator mode (jump -> op -> back)",
		},
		{
			"R",
			function()
				require("flash").treesitter_search()
			end,
			mode = { "o", "x" },
			desc = "Remote search block by treesitter",
		},
		{
			"<C-s>",
			function()
				require("flash").toggle()
			end,
			mode = "c",
			desc = "Toggle flash",
		},
	},
}
