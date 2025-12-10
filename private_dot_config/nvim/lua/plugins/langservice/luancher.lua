return {
	-- overseer.nvim --
	-- predefined (build/run) tasks
	-- 预定义的 构建 / 运行 任务
	{
		"stevearc/overseer.nvim",
		lazy = true,
		cmd = "OverseerRun",
		config = function()
			require("config.langservice.launcher")
		end,
	},
	-- nvim-dap --
	-- debug support
	{
		-- dap ui --
		"rcarriga/nvim-dap-ui",
		lazy = true,
		cmd = { "DapContinue", "DapNew" },
		dependencies = {
			-- debug core --
			{
				"mfussenegger/nvim-dap",
				dependencies = {
					-- persistent breakpoints --
					-- 持久化断点支持
					{
						"Weissle/persistent-breakpoints.nvim",
						event = "BufReadPost",
						config = function()
							require("config.langservice.dap.breakpoint")
						end,
					},
					-- virtual text --
					-- 虚拟文本
					{
						"theHamsta/nvim-dap-virtual-text",
						config = function()
							require("config.langservice.dap.virtualtext")
						end,
					},
					-- telescope integration --
					-- 与 telescope 的集成
					"nvim-telescope/telescope-dap.nvim",
				},
				config = function()
					require("config.langservice.dap.dap")
				end,
			},
			"nvim-neotest/nvim-nio",
		},
		config = function()
			require("config.langservice.dap.dapui")
		end,
	},
}
