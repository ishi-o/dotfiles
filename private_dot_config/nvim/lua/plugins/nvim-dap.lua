return {
	-- nvim-dap
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"theHamsta/nvim-dap-virtual-text",
			"nvim-telescope/telescope-dap.nvim",
		},
		config = function()
			require("config.nvim-dap")
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
	},
	{
		"Weissle/persistent-breakpoints.nvim",
		event = "BufReadPost",
	},
}
