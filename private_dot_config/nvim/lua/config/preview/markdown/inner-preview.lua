require("render-markdown").setup({
	renderer = "glow",
	file_types = { "markdown", "codecompanion" },
	pletions = { lsp = { enabled = true } },
})
