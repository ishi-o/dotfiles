vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		width = math.floor(vim.o.columns * 0.25),
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = false,
	},
})

vim.keymap.set("n", "<C-g>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })
