require("conform").setup({
	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		lua = { "stylua" },
		markdown = { "markdownlint" },
		-- python = { "ruff" },
		-- python = { "autopep8" },
		python = { "black" },
		bash = { "shfmt" },
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		require("conform").format({ async = false, lsp_fallback = true })
	end,
})
