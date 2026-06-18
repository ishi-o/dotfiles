require("snacks").setup({
	bigfile = { enabled = true },
	dashboard = { enabled = true },
	dim = { enabled = false },
	explorer = { enabled = false },
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
			preview = {
				keys = {
					["<C-c>"] = { "cancel", mode = { "i", "n" } },
				},
			},
		},
		layout = { layout = { backdrop = false } },
		sources = {
			harpoon = {
				finder = function(opts, ctx)
					local harpoon = require("harpoon"):list()
					local files = {}
					local cwd = vim.loop.cwd()

					for idx, item in ipairs(harpoon.items) do
						if item and item.value:match("%S") then
							local file_path = item.value
							local ft = vim.filetype.match({ filename = file_path })

							table.insert(files, {
								cwd = cwd,
								text = item.value,
								file = file_path,
								idx = idx,
								ft = ft,
							})
						end
					end
					return files
				end,
				format = "file",
				preview = "file",
				confirm = "jump",
			},
		},
	},
	scope = { enabled = true },
	scroll = { enabled = true },
	words = { enabled = true },
	zen = { enabled = true },
})
