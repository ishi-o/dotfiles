local map = vim.keymap.set

require("toggleterm").setup({
	start_in_insert = false,
	direction = "float",
	float_opts = {
		width = function()
			return math.floor(vim.o.columns * 1)
		end,
		height = function()
			return math.floor(vim.o.lines * 0.3)
		end,
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

-- map({ "n", "t" }, "<C-t>", ":ToggleTerm<CR>", { noremap = true })
map("n", "<C-t>", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":ToggleTerm<CR>", true, false, true), "n", false)
end, { noremap = true })
map("t", "<C-t>", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>:ToggleTerm<CR>", true, false, true), "n", false)
end, { noremap = true })

-- vim.keymap.set("t", "<C-t>", "<C-\\><C-n>:ToggleTerm<CR>", { noremap = true })
map("t", "<C-q>", "<C-\\><C-n>", { noremap = true })
