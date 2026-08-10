local ok, gitsigns = pcall(require, "gitsigns")
if ok then
	gitsigns.setup({
		on_attach = function(bufnr)
			if vim.bo[bufnr].filetype == "bigfile" then
				return false
			end
		end,
		signs = {
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
	})
end
