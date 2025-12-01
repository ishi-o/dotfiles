return {
	-- remote-sshfs.nvim --
	-- ssh filesystem integration
	{
		"nosduco/remote-sshfs.nvim",
		lazy = true,
		cmd = {
			"RemoteSSHFSConnect",
			"RemoteSSHFSFindFiles",
			"RemoteSSHFSLiveGrep",
		},
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("config.remote.sshfs")
		end,
	},
	-- oil.nvim --
	-- remote file editor
	{
		"stevearc/oil.nvim",
		lazy = true,
		cmd = "Oil",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("config.remote.oil")
		end,
	},
}
