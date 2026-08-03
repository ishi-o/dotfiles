local wk = require("which-key")
wk.setup({
	win = {
		border = "rounded",
		row = math.huge,
		col = math.huge,
		width = 0.3,
		height = 0.9,
		no_overlap = true,
	},
	max_description_length = 30,
	show = {
		delay = 600,
	},
})
wk.add({
	{
		cond = function()
			return not vim.g.vscode
		end,
		{
			"<C-_>",
			function()
				wk.show({ global = false })
			end,
			mode = { "n", "x", "i", "c", "o", "t" },
			desc = "Buffer Local Keymaps",
		},
		require("config.keybind.general"),
		require("config.keybind.langs"),
		require("config.keybind.mapgroup"),
		require("config.keybind.enhancement"),
		require("config.keybind.extra"),
	},
	{
		cond = function()
			return vim.g.vscode
		end,
		require("config.keybind.vscode"),
	},
})
