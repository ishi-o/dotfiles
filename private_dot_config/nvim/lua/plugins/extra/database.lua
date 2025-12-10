return {
	-- vim-dadbod --
	-- database connection ui support
	-- 数据库连接 支持
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
			require("config.extra.database")
		end,
	},
}
