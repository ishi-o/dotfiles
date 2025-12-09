require("snacks").setup({
	bigfile = { enabled = true },
	dashboard = { enabled = true },
	explorer = { enabled = true },
	indent = { enabled = true },
	input = { enabled = true },
	notifier = { enabled = false },
	picker = {
		enabled = true,
		sources = {
			explorer = {
				layout = {
					layout = {
						width = 0.3,
						min_width = 0.3,
					},
				},
			},
		},
	},
	scope = { enabled = true },
	scroll = { enabled = true },
	words = { enabled = true },
})
