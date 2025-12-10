return {
	-- dial.nvim --
	-- constant / enum  inc/dec
	-- 常数 / 枚举 / 日期 的 增减
	{
		"monaqa/dial.nvim",
		lazy = true,
		module = "dial.map",
		config = function()
			require("config.enhancement.dial")
		end,
	},
}
