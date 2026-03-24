return {
	{
		"ishi-o/nvim-mybatis",
		-- branch = "feat/generator",
		dir = vim.env.HOME .. "/repos/nvim-mybatis",
		config = function()
			require("nvim-mybatis").setup({})
		end,
		dev = true,
	},
}
