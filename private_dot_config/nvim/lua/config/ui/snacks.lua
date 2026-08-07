require("snacks").setup({
	bigfile = { enabled = true },
	dashboard = { enabled = false },
	dim = { enabled = false },
	explorer = { enabled = false },
	indent = { enabled = true },
	input = { enabled = false },
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
			preview = {
				keys = {
					["<C-c>"] = { "cancel", mode = { "i", "n" } },
				},
			},
		},
		layout = { layout = { backdrop = false } },
	},
	scope = { enabled = true },
	scroll = { enabled = true },
	words = { enabled = true },
	zen = { enabled = false },
})
