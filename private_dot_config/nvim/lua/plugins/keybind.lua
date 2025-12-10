return {
	-- which-key.nvim --
	-- quick keybind and guide
	-- 键位管理器与提示窗口
	{
		"folke/which-key.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("config.keybind")
		end,
	},
}
