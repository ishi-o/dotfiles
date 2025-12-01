require("render-markdown").setup({
	renderer = "glow",
	file_types = { "markdown", "codecompanion" },
	-- win_options = {
	-- 	conceallevel = {
	-- 		default = 1,
	-- 		rendered = 2,
	-- 	},
	-- 	concealcursor = {
	-- 		default = "",
	-- 		rendered = "nvic",
	-- 	},
	-- },
	completions = { lsp = { enabled = true } },
})
