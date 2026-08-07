require("render-markdown").setup({
	file_types = { "markdown" },
	completions = { lsp = { enabled = true } },
	ignore = function(buf)
		return vim.bo[buf].buftype ~= "" or vim.api.nvim_buf_get_name(buf) == ""
	end,
})
