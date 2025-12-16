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
		desc = "Toggle diagnostic (virtual lines)",
	},
	{
		"<leader>uz",
		"<cmd>lua Snacks.zen()<CR>",
		desc = "Toggle zen mode",
	},
	{
		"<leader>uZ",
		"<cmd>lua Snacks.zen.zoom()<CR>",
		desc = "Toggle zoom mode",
	},
	{
		"<leader>uD",
		(function()
			local enabled = false
			return function()
				if enabled then
					Snacks.dim.disable()
				else
					Snacks.dim.enable()
				end
				enabled = not enabled
			end
		end)(),
		desc = "Toggle dim",
	},
	{
		"<leader>ut",
		(function()
			local enabled = true
			return function()
				if enabled then
					Snacks.indent.disable()
				else
					Snacks.indent.enable()
				end
				enabled = not enabled
			end
		end)(),
		desc = "Toggle indent",
	},
	{
		"<leader>uS",
		(function()
			local enabled = true
			return function()
				if enabled then
					Snacks.scroll.disable()
				else
					Snacks.scroll.enable()
				end
				enabled = not enabled
			end
		end)(),
		desc = "Toggle smooth scroll",
	},
	{
		"<leader>uc",
		function()
			local bg = vim.opt.background:get() or "light"
			vim.opt.background = (bg == "light") and "dark" or "light"
			-- local bg = vim.o.background or "light"
			-- vim.o.background = bg == "light" and "dark" or "light"
		end,
		desc = "Switch colorscheme (light / dark)",
	},
	{
		"<leader>uC",
		function()
			Snacks.picker.colorschemes()
		end,
		desc = "Colorschemes",
	},
}
