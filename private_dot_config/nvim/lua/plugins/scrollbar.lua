return {
	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("gitsigns").setup()
			require("scrollbar").setup({
				handle = {
					color = "#93B259",
					color_nr = 150,
				},
				marks = {
					Cursor = {
						text = "█",
					},
					Search = {
						text = { "█" },
						color = "#FFBC00",
					},
					Error = {
						text = { "█" },
						color = "#FF5555",
						color_nr = 9,
					},
					Warn = {
						text = { "█" },
						color = "#FFCC00",
						color_nr = 3,
					},
					Info = {
						text = { "█" },
						color = "#55AAFF",
						color_nr = 12,
					},
				},
			})
			require("scrollbar.handlers.search").setup({})
			require("scrollbar.handlers.gitsigns").setup()
		end,
	},
}
