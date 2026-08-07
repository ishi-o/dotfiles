local ok, neogit = pcall(require, "neogit")
if ok then
	neogit.setup({
		diff_viewer = "diffview",
		integrations = {
			diffview = true,
			telescope = false,
		},
	})
end
