return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("config.extra.git.gitsigns")
		end,
	},
	{
		"NeogitOrg/neogit",
		lazy = true,
		cmd = "Neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"sindrets/diffview.nvim",
				config = function()
					require("config.extra.git.diffview")
				end,
			},
		},
		config = function()
			require("config.extra.git.neogit")
		end,
	},
}
