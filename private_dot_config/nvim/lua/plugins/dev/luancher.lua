return {
	-- overseer --
	-- predefined (build/run) tasks
	{
		"stevearc/overseer.nvim",
		lazy = true,
		cmd = "OverseerRun",
		config = function()
			require("config.dev.launcher")
		end,
	},
	-- dap --
	-- debug
	{
		-- dap ui --
		"rcarriga/nvim-dap-ui",
		lazy = false,
		-- cmd = { "DapContinue", "DapNew" },
		dependencies = {
			-- debug core --
			{
				"mfussenegger/nvim-dap",
				dependencies = {
					-- virtual text --
					"theHamsta/nvim-dap-virtual-text",
					-- telescope integration --
					"nvim-telescope/telescope-dap.nvim",
				},
			},
			"nvim-neotest/nvim-nio",
			-- persistent breakpoints --
			{
				"Weissle/persistent-breakpoints.nvim",
				event = "BufReadPost",
			},
		},
		config = function()
			require("config.dev.dap")
		end,
	},
}
