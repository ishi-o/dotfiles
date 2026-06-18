return {
	{
		"stevearc/overseer.nvim",
		lazy = true,
		cmd = {
			"OverseerRun",
			"OverseerToggle",
			"OverseerTaskAction",
		},
		config = function()
			require("config.langservice.launcher")
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		enabled = false,
		lazy = true,
		cmd = { "DapContinue", "DapNew" },
		dependencies = {
			{
				"mfussenegger/nvim-dap",
				dependencies = {
					{
						"Weissle/persistent-breakpoints.nvim",
						event = "BufReadPost",
						config = function()
							require("config.langservice.dap.breakpoint")
						end,
					},
					{
						"theHamsta/nvim-dap-virtual-text",
						config = function()
							require("config.langservice.dap.virtualtext")
						end,
					},
					config = function()
						require("config.langservice.dap.dap")
					end,
				},
				"nvim-neotest/nvim-nio",
				{
					"leoluz/nvim-dap-go",
					opts = {},
				},
				config = function()
					require("config.langservice.dap.dapui")
				end,
			},
		},
	},
}
