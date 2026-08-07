return {
	{ "<leader>cc", desc = "Code actions" },
	{ "<leader>C", desc = "Code actions" },
	{ "<leader>cr", desc = "Rename" },
	{
		"<leader>co",
		function()
			vim.lsp.buf.code_action({
				context = {
					only = { "source.organizeImports" },
					apply = true,
				},
			})
		end,
		desc = "Organize imports",
	},
	{
		"<leader>ct",
		function()
			vim.lsp.buf.code_action({
				context = {
					only = { "refactor.rewrite" },
					apply = true,
				},
			})
		end,
		desc = "Rewrite structure",
	},
	{
		"<leader>cf",
		function()
			vim.lsp.buf.code_action({
				context = {
					only = { "source.fixAll" },
					apply = true,
				},
			})
		end,
		desc = "Rewrite structure",
	},
}
