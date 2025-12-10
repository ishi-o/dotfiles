require("harpoon"):setup({
	menu = {
		width = vim.api.nvim_win_get_width(0) - 4,
	},
	settings = {
		save_on_toggle = true,
	},
})
require("telescope").load_extension("harpoon")
