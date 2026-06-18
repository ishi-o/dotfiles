return {
	{
		"kristijanhusak/vim-dadbod-ui",
		enabled = false,
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
					"pgsql",
				},
				lazy = true,
			},
			config = function()
				require("config.extra.database")
			end,
		},
	},
}
