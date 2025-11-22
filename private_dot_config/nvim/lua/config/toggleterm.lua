local map = vim.keymap.set

require("toggleterm").setup({
	start_in_insert = true,
	direction = "float",
	-- direction = "horizontal",
	open_mapping = [[<C-t>]],
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
	winbar = {
		enabled = true,
		name_formatter = function(term)
			return string.format("%d", term.id)
		end,
	},
})

map("t", "<C-q>", "<C-\\><C-n>", { noremap = true })
