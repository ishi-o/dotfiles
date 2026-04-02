return {
	{
		"ishi-o/nvim-mybatis",
		-- enabled = false,
		branch = "main",
		-- dir = vim.env.HOME .. "/repos/nvim-mybatis",
		config = function()
			require("nvim-mybatis").setup({})
		end,
		-- dev = true,
	},
}
