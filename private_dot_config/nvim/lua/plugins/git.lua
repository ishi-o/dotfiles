return {
	-- git
	{
		"tpope/vim-fugitive",
		"lewis6991/gitsigns.nvim",
		config = function()
			require("config.git")
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
}
