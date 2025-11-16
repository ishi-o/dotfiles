vim.g.have_nerd_font = true

require("neo-tree").setup({
	close_if_last_window = false,
	enable_git_status = true,
	enable_diagnostics = true,
	filesystem = {
		filtered_items = {
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = false,
		},
		follow_current_file = {
			enabled = true,
		},
		use_libuv_file_watcher = true,
		renderer = {
			icons = {
				enable = true
			},
		},
	},
})

vim.keymap.set({"n", "x"}, "<C-h>", ":Neotree toggle<CR>", { noremap = true })
