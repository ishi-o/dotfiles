local ok, notify = pcall(require, "notify")
if not ok then
	return
end
notify.setup({
	max_width = function()
		return math.floor(vim.o.columns * 0.3)
	end,
	timeout = 3000,

	render = "wrapped-compact",
})
