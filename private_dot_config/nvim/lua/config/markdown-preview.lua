local map = vim.keymap.set

require("render-markdown").setup({
	renderer = "glow",
	file_types = { "markdown", "codecompanion" },
})

map("n", "<C-S-s>", ":MarkdownPreview<CR>", { desc = "MarkdownPreview" })
