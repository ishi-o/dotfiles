return {
	-- vim.dadbod-ui --
	-- database connection ui support
	{
		"kristijanhusak/vim-dadbod-ui",
		lazy = true,
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		dependencies = {
			{
				"tpope/vim-dadbod",
				lazy = true,
			},
			{
				"kristijanhusak/vim-dadbod-completion",
				ft = {
					"sql",
					"mysql",
					"plsql",
				},
				lazy = true,
			},
		},
		config = function()
			require("config.dev.database")
		end,
	},
}
