return {
	{
		cond = function()
			return _G.plugin_installed("flash.nvim")
		end,
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
