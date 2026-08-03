local ok, neogit = pcall(require, "neogit")
if ok then
	neogit.setup({
		integrations = {
			telescope = false,
		},
	})
end
