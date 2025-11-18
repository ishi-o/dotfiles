-- need ripgrep

local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
	defaults = {
		file_ignore_patterns = { "node_modules/", ".git/", "target/" },
		path_display = { "truncate" },
		mappings = {
			i = {
				--	["<C-h>"] = "which_key"
			}
		}
	},
	pickers = {
		find_files = {
			hidden = true
		}
	},
	extensions = {
		file_browser = {
			theme = "ivy",
			hijack_netrw = true,
		}
	}
})

if vim.fn.filereadable(vim.fn.stdpath("data") .. "/lazy/telescope-fzf-native.nvim/build/libfzf.so") == 0 then
	os.execute("cd " .. vim.fn.stdpath("data") .. "/lazy/telescope-fzf-native.nvim && cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release >/dev/null 2>&1")
end
telescope.load_extension("fzf")
telescope.load_extension("file_browser")

vim.keymap.set("n", "<C-f>", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<C-g>", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<C-b>", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<C-?>", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<C-e>", ":Telescope file_browser<CR>", { desc = "Telescope file browser" })
