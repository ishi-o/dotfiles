local M = {}

function M.setup()
	vim.diagnostic.config({
		virtual_lines = {
			current_line = true,
		},
		-- virtual_lines = true,
		virtual_text = false,
		signs = true,
		update_in_insert = false,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "none",
			source = true,
			header = "",
			prefix = "",
		},
	})
end

function M.load_trouble()
	require("trouble").setup()
end

return M
