local map = vim.keymap.set
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

map("n", "<leader>?", function()
	wk.show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })
