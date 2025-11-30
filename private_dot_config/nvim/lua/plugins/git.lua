local func = require("vim.func")
return {
	-- lazygit.nvim --
	-- lazygit integration
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	-- gitsigns.nvim --
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("config.git.gitsigns")
		end,
	},
	-- neogit --
	{
		"NeogitOrg/neogit",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",

			"nvim-telescope/telescope.nvim",
		},
		cmd = "Neogit",
		config = function()
			require("config.git.neogit")
		end,
	},
}
