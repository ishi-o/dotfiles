local map = vim.keymap.set
local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
	defaults = {
		file_ignore_patterns = {
			"node_modules/",
			"target/",
			"build/",
			"dist/",
			"vendor/",
			"__pycache__/",
			"bin/",
			"lib/",
			"share/",
			"man/",
			".git/",
			".svn/",
			".hg/",
			".nvm/",
			".cache/",
			".m2/",
			".sdkman/",
			".cargo/",
			".conda/",
			".vscode-server/",
			".workspace/",
			"opt/",
			"%.swp",
			"%.bak",
			"%.tmp",
			"%.so",
			"%.dll",
			"%.exe",
			"%.jar",
		},
		path_display = { "truncate" },
		mappings = {
			n = {
				["<leader>c"] = "close",
			},
		},
	},
	pickers = {
		find_files = {
			hidden = true,
		},
	},
	extensions = {
		file_browser = {
			theme = "ivy",
			hijack_netrw = true,
		},
	},
})

if vim.fn.filereadable(vim.fn.stdpath("data") .. "/lazy/telescope-fzf-native.nvim/build/libfzf.so") == 0 then
	os.execute(
		"cd "
			.. vim.fn.stdpath("data")
			.. "/lazy/telescope-fzf-native.nvim && cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release >/dev/null 2>&1"
	)
end
telescope.load_extension("lazygit")
telescope.load_extension("fzf")
telescope.load_extension("file_browser")
telescope.load_extension("noice")

map("n", "<leader>fd", builtin.find_files, { desc = "[F]in[d] files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]reps" })
map("n", "<leader>fb", builtin.buffers, { desc = "[F]ind [B]uffers" })
map("n", "<leader>fo", builtin.oldfiles, { desc = "[F]ind [O]ldfiles" })
map("n", "<leader>fe", "<cmd>Telescope file_browser<CR>", { desc = "[F]ile [E]xplorer" })
map("n", "<C-?>", builtin.help_tags, { desc = "Telescope help tags" })
