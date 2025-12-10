return {
	-- toggleterm.nvim --
	-- inner terminal integration
	-- 内置终端优化
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("config.enhancement.toggleterm")
		end,
	},
}
