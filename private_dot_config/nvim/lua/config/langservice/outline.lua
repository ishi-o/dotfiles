local ok, aerial = pcall(require, "aerial")
if ok then
	aerial.setup({
		layout = {
			max_width = { 0.3 },
			width = 0.3,
			min_width = 0.3,
		},
	})
end
