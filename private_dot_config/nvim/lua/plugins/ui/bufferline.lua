return {
	-- bufferline.nvim --
	-- bufferline
	-- buffer 插件
	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("config.ui.bufferline")
		end,
	},
}
