return {
	-- overseer --
	-- predefined (build/run) tasks
	{
		"stevearc/overseer.nvim",
		config = function()
			require("config.dev.runner.tasks")
		end,
	},
	-- dap --
	-- debug
	{
		-- dap ui --
		"rcarriga/nvim-dap-ui",
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
			require("config.dev.runner.dap")
		end,
	},
}
