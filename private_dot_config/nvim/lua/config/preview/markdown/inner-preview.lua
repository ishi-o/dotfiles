require("render-markdown").setup({
	renderer = "glow",
	file_types = { "markdown", "codecompanion", "Avante" },
	pletions = { lsp = { enabled = true } },
})
