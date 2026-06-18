return {
	{
		"JuanZoran/Trans.nvim",
		enabled = false,
		dependencies = { "kkharji/sqlite.lua" },
		optional = false,
		build = function()
			require("Trans").install()
		end,
		lazy = true,
		cmd = { "Translate", "TransPlay" },
		keys = {
			{ "<leader>TT", mode = { "n", "x" }, "<cmd>Translate<CR>", desc = "󰊿 Translate" },
			{ "<leader>TP", mode = { "n", "x" }, "<cmd>TransPlay<CR>", desc = " Auto Play" },
			opts = {
				frontend = {
					default = {
						auto_play = false,
						animation = {
							open = false,
							close = false,
							interval = 12,
						},
					},
				},
				{
					"potamides/pantran.nvim",
					enabled = false,
					lazy = true,
					module = "pantran",
					keys = {
						{
							"<leader>TO",
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
						config = function()
							require("pantran").setup({
								default_engine = "yandex",
								engines = {
									yandex = {
										fallback = {
											default_source = "en",
											default_target = "zh",
										},
										apertium = {
											fallback = {
												default_source = "eng",
												default_target = "zho",
											},
										},
									},
								},
							})
						end,
					},
				},
			},
		},
	},
}
