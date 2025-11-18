require("conform").setup({
	formatters_by_ft = {
		-- java = { "google-java-format" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		lua = { "stylua" },
		markdown = { "markdownlint" },
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		require("conform").format({ async = false, lsp_fallback = true })
	end,
})
