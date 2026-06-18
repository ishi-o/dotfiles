return {
	{
		"nosduco/remote-sshfs.nvim",
		enabled = false,
		lazy = true,
		cmd = {
			"RemoteSSHFSConnect",
			"RemoteSSHFSFindFiles",
			"RemoteSSHFSLiveGrep",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("config.remote.sshfs")
		end,
	},
	{
		"stevearc/oil.nvim",
		enabled = false,
		lazy = true,
		cmd = "Oil",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("config.remote.oil")
		end,
	},
}
