return {
	-- neo-tree.nvim --
	-- file-tree
	{
		"nvim-neo-tree/neo-tree.nvim",
		optional = true,
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("config.filetree.neo-tree")
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		enabled = false,
		config = function()
			require("config.filetree.nvim-tree")
		end,
	},
}
