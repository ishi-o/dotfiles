local map = vim.keymap.set

require("render-markdown").setup({
	renderer = "glow",
	file_types = { "markdown", "codecompanion" },
})

map("n", "<leader>md", "<cmd>MarkdownPreview<CR>", { desc = "MarkdownPreview" })
