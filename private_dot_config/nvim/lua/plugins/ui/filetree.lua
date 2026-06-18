return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("config.ui.filetree.neo-tree")
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		enabled = false,
		config = function()
			require("config.ui.filetree.nvim-tree")
		end,
	},
}
