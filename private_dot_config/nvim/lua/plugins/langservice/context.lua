return {
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("config.langservice.context")
		end,
	},
}
