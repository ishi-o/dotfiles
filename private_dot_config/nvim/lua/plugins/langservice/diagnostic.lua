return {
	-- trouble.nvim --
	-- quick diagnostic
	-- 快速的诊断信息查看与跳转
	{
		"folke/trouble.nvim",
		lazy = true,
		cmd = "Trouble",
		config = function()
			require("config.langservice.diagnostic")
		end,
	},
}
