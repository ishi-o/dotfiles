return {
	-- ssh filesystem
	{
		"nosduco/remote-sshfs.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("config.sshfs")
		end,
	},
}
