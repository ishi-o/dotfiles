-- unset --
return {
	{
		"<leader>ur",
		function()
			vim.cmd("redraw")
			vim.cmd("noh")
			vim.cmd("diffupdate")
		end,
		desc = "Redraw, Noh, Diff update",
	},
	{
		"<leader>ud",
		function()
			local current_config = vim.diagnostic.config().virtual_lines
			local new_config
			if current_config == false then
				new_config = { current_line = true }
			else
				new_config = false
			end
			vim.diagnostic.config({ virtual_lines = new_config })
		end,
		desc = "Diagnostic (virtual lines)",
	},
}
