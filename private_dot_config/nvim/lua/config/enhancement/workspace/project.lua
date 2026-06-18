local ok, project_nvim = pcall(require, "project_nvim")
if ok then
	project_nvim.setup({
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
end
