require("toggleterm").setup({
	-- start_in_insert = true,
	direction = "float",
	float_opts = {
		width = function() return math.floor(vim.o.columns * 1) end,
		height = function() return math.floor(vim.o.lines * 0.3) end,
		row = function()
			return vim.o.lines - math.floor(vim.o.lines * 0.25) - 1
		end,
		col = function()
			return math.floor((vim.o.columns - (vim.o.columns * 0.9)) / 2)
		end,
		border = "curved",
		winblend = 40,
	},
})

vim.keymap.set("n", "<C-t>", ":ToggleTerm<CR>", { noremap = true })
-- vim.keymap.set("t", "<C-t>", "<C-\\><C-n>:ToggleTerm<CR>", { noremap = true })
vim.keymap.set("t", "<C-q>", "<C-\\><C-n>", { noremap = true })
