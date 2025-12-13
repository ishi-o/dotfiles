return {
	-- neo-tree.nvim --
	-- file-tree
	-- 文件树
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		optional = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("config.ui.filetree.neo-tree")
		end,
	},
	-- nvim-tree.lua --
	-- file-tree
	-- 文件树
	{
		"nvim-tree/nvim-tree.lua",
		enabled = false,
		config = function()
			require("config.ui.filetree.nvim-tree")
		end,
	},
}
