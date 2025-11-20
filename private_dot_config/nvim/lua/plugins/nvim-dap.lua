return {
	-- nvim-dap
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-telescope/telescope-dap.nvim",
		},
		config = function()
			require("config.nvim-dap")
		end,
	},
}
