return {
	-- null-ls
	-- {
	-- 	"nvimtools/none-ls.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- 	config = function()
	-- 		require("config.linter")
	-- 	end,
	-- },
	{
		"mfussenegger/nvim-lint",
		event = "BufReadPost",
		config = function()
			require("config.linter")
		end,
	},
}
