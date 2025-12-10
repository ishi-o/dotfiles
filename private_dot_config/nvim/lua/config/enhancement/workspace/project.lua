require("project_nvim").setup({
	detection_methods = { "pattern", "lsp" },
	patterns = {
		".git",
		"package.json",
		"pyproject.toml",
		"Cargo.toml",
		"Makefile",
		"CMakeLists.txt",
	},
})
