return {
	-- dressing.nvim --
	-- picker (vim.ui.select)
	-- vim.ui.select 优化
	{
		"stevearc/dressing.nvim",
		config = function()
			require("config.ui.select")
		end,
	},
}
