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
			return vim.o.lines - math.floor(vim.o.lines * 0.3) - 3
		end,
		col = 0,
		border = "curved",
		winblend = 20,
	},
	winbar = {
		enabled = true,
		name_formatter = function(term)
			return string.format("%d", term.id)
		end,
	},
})
