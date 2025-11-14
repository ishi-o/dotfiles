require("toggleterm").setup({
	--	start_in_insert = true,
	direction = "horizontal",
	float_opts = {
		winblend = 3,
	},
})

vim.keymap.set("n", "<C-t>", ":ToggleTerm<CR>", { noremap = true })
-- vim.keymap.set("t", "<C-t>", "<C-\\><C-n>:ToggleTerm<CR>", { noremap = true })
vim.keymap.set("t", "<C-q>", "<C-\\><C-n>", { noremap = true })
