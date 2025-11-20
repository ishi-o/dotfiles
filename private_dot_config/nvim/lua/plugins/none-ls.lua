return {
	-- null-ls
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("config.none-ls")
		end,
	},
}
