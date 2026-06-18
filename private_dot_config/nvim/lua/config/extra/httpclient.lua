local ok, kulala = pcall(require, "kulala")
if ok then
	kulala.setup({
		global_keymaps = false,
		global_keymaps_prefix = "<leader>R",
		kulala_keymaps_prefix = "",
	})
end
