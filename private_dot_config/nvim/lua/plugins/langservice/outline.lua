return {
	-- aerial.nvim --
	-- outline
	-- 大纲
	{
		"stevearc/aerial.nvim",
		lazy = true,
		cmd = "AerialToggle",
		config = function()
			require("config.langservice.outline")
		end,
	},
}
