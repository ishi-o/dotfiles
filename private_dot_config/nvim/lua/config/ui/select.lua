local ok, dressing = pcall(require, "dressing")
if not ok then
	return
end
dressing.setup({
	select = {
		enabled = true,
		backend = { "telescope", "builtin" },
	},
})
