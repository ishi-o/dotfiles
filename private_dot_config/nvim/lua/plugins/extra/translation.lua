return {
	{
		"JuanZoran/Trans.nvim",
		dependencies = { "kkharji/sqlite.lua" },
		optional = true,
		build = function()
			require("Trans").install()
		end,
		lazy = true,
		cmd = "Translate",
		keys = {
			{ "<leader>T", mode = { "n", "x" }, "<cmd>Translate<CR>", desc = "󰊿 Translate" },
			-- { "<leader>T", mode = { "n", "x" }, "<cmd>TransPlay<CR>", desc = " Auto Play" },
		},
		opts = {
			frontend = {
				default = {
					animation = {
						open = false,
						close = false,
						interval = 12,
					},
				},
			},
		},
	},
	{
		"potamides/pantran.nvim",
		lazy = true,
		module = "pantran",
		keys = {
			{
				"<leader>TT",
				function()
					return require("pantran").motion_translate()
				end,
				mode = { "n", "x" },
				expr = true,
			},
			{
				"<leader>TR",
				function()
					return require("pantran").motion_translate() .. "_"
				end,
				mode = "n",
				expr = true,
			},
		},
		config = function()
			require("pantran").setup({
				-- default_engine = "deepl",
				default_engine = "yandex",
				-- default_engine = "apertium",
				engines = {
					yandex = {
						fallback = {
							default_source = "en",
							default_target = "zh",
						},
					},
					apertium = {
						fallback = {
							default_source = "eng",
							default_target = "zho",
						},
					},
				},
			})
		end,
	},
}
