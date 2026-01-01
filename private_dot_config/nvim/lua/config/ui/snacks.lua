require("snacks").setup({
	bigfile = { enabled = true },
	dashboard = { enabled = true },
	dim = { enabled = true },
	explorer = { enabled = true },
	indent = { enabled = true },
	input = { enabled = true },
	notifier = { enabled = false },
	picker = {
		enabled = true,
		win = {
			input = {
				keys = {
					["<C-c>"] = { "cancel", mode = { "i", "n" } },
				},
			},
			list = {
				keys = {
					["<C-c>"] = { "cancel", mode = { "i", "n" } },
				},
			},
		},
		layout = { layout = { backdrop = false } },
		sources = {
			explorer = {
				layout = {
					layout = {
						width = 0.3,
						min_width = 0.3,
					},
				},
				win = {
					list = {
						keys = { ["<C-t>"] = "" },
					},
					input = {
						keys = { ["<C-t>"] = "" },
					},
				},
			},
		},
	},
	scope = { enabled = true },
	scroll = { enabled = true },
	words = { enabled = true },
	zen = { enabled = true },
})
