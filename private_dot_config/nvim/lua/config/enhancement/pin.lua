local ok, harpoon = pcall(require, "harpoon")
if ok then
	harpoon:setup({
		menu = {
			width = vim.api.nvim_win_get_width(0) - 4,
		},
		settings = {
			save_on_toggle = true,
		},
	})
end

local ok2, telescope = pcall(require, "telescope")
if ok2 then
	telescope.load_extension("harpoon")
end
