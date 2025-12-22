-- TODO: add nvim-treesitter-context
return {
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				mode = "cursor",
				max_lines = 3,
			})
		end,
	},
}
