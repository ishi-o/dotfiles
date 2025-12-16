require("notify").setup({
	max_width = function()
		return math.floor(vim.o.columns * 0.4)
	end,
	timeout = 3000,

	render = "wrapped-compact",
})
