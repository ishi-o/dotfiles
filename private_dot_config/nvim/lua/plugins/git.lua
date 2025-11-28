return {
	-- vim-fugitive --
	-- git integration
	{
		"tpope/vim-fugitive",
		"lewis6991/gitsigns.nvim",
		config = function()
			require("config.git")
		end,
	},
	-- lazygit.nvim --
	-- lazygit integration
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
}
