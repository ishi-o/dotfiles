local M = {}

function M.init()
	-- mark netrw as loaded so it's not loaded at all.
	vim.g.loaded_netrwPlugin = 1
end

function M.setup()
	require("yazi").setup({
		open_for_directories = false,
		keymaps = {
			show_help = "<F1>",
		},
	})
end

return M
