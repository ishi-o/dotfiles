local telescope = require("telescope")

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
				["q"] = "close",
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
telescope.load_extension("projects")
telescope.load_extension("harpoon")
telescope.load_extension("refactoring")
