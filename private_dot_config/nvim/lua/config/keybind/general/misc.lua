-- misc --
return {
	-- change mode --
	{
		-- Using <C-c> in insert mode breaks neo-tree
		{ "jj", "<Esc>", mode = "i", desc = "Return to normal mode" },
		-- <Esc> in command mode has some issues
		{ "jj", "<C-c>", mode = "c", desc = "Return to normal mode" },
	},

	-- save --
	{ "<leader>w", "<cmd>w<CR>", desc = "Save file" },

	-- quit --
	{ "<leader>z", "<cmd>qa<CR>", desc = "Quit neovim" },
	{ "z<leader>", "<cmd>qa<CR>", desc = "Quit neovim" },

	-- move line --
	{
		{
			"<C-j>",
			function()
				vim.cmd("m+" .. vim.v.count1)
				vim.cmd("normal! ==")
			end,
			desc = "Move line down",
		},
		{
			"<C-k>",
			function()
				vim.cmd("m-" .. (vim.v.count1 + 1))
				vim.cmd("normal! ==")
			end,
			desc = "Move line up",
		},
		{
			"<C-j>",
			function()
				if vim.fn.mode() ~= "V" then
					return
				end
				local start_line = vim.fn.line("v")
				local end_line = vim.fn.line(".")
				if start_line > end_line then
					start_line, end_line = end_line, start_line
				end
				local num_lines = end_line - start_line + 1
				local last_buf_line = vim.api.nvim_buf_line_count(0)
				if end_line >= last_buf_line then
					return
				end
				vim.cmd(string.format("silent %d,%dmove %d", start_line, end_line, end_line + vim.v.count1))
				local new_start_line = start_line + vim.v.count1
				local new_end_line = new_start_line + num_lines - 1
				vim.fn.setpos("'<", { 0, new_start_line, 1, 0 })
				vim.fn.setpos("'>", { 0, new_end_line, 2147483647, 0 })
				vim.cmd("normal! gv")
			end,
			mode = "x",
			desc = "Move selected lines down",
		},
		{
			"<C-k>",
			function()
				if vim.fn.mode() ~= "V" then
					return
				end
				local start_line = vim.fn.line("v")
				local end_line = vim.fn.line(".")
				if start_line > end_line then
					start_line, end_line = end_line, start_line
				end
				local num_lines = end_line - start_line + 1
				if start_line <= 1 then
					return
				end
				vim.cmd(string.format("silent %d,%dmove %d", start_line, end_line, start_line - (vim.v.count1 + 1)))
				local new_start_line = start_line - vim.v.count1
				local new_end_line = new_start_line + num_lines - 1
				vim.fn.setpos("'<", { 0, new_start_line, 1, 0 })
				vim.fn.setpos("'>", { 0, new_end_line, 2147483647, 0 })
				vim.cmd("normal! gv")
			end,
			mode = "x",
			desc = "Move selected lines up",
		},
	},
}
