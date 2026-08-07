require("lazydev").setup({
	library = {
		"lazy.nvim",
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		{ path = "snacks.nvim", words = { "Snacks" } },
	},
})
