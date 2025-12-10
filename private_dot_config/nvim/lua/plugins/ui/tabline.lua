return {
	-- scope.nvim --
	-- tabline
	-- 分页栏
	{
		"tiagovla/scope.nvim",
		config = function()
			require("config.ui.tabline")
		end,
	},
}
