return {
	-- nvim-autopairs --
	-- add pair quotes / parenthesis
	-- 自动配对括号
	{
		"windwp/nvim-autopairs",
		config = function()
			require("config.enhancement.autopairs")
		end,
	},
}
