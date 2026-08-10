local function move_or_kitty(dir)
	local dir_map = { h = "left", j = "bottom", k = "top", l = "right" }
	local current = vim.fn.winnr()
	vim.cmd("wincmd " .. dir)
	if vim.fn.winnr() == current then
		vim.fn.system("kitty @ focus-window --match neighbor:" .. dir_map[dir])
	end
end

local function smart_close()
	local wins = vim.api.nvim_tabpage_list_wins(0)
	local buf = vim.api.nvim_get_current_buf()
	local win = vim.api.nvim_get_current_win()

	if #wins > 1 then
		vim.api.nvim_win_close(win, false)
	else
		vim.api.nvim_buf_delete(buf, {})
	end
end

return {
	{
		{
			"<leader>V",
			function()
				vim.ui.input({ prompt = "Horizontal split file: ", completion = "file" }, function(filename)
					if filename == nil then
						return
					end
					vim.api.nvim_cmd({
						cmd = "split",
						args = filename == "" and {} or { filename },
					}, {})
				end)
			end,
			desc = "Horizontal Split (input filename)",
		},
		{
			"<leader>v",
			function()
				vim.ui.input({ prompt = "Vertical split file: ", completion = "file" }, function(filename)
					if filename == nil then
						return
					end
					vim.api.nvim_cmd({
						cmd = "vsplit",
						args = filename == "" and {} or { filename },
					}, {})
				end)
			end,
			desc = "Vertical Split (input filename)",
		},
		{ "<leader>-", "<cmd>split<CR>", desc = "Horizontal Split" },
		{ "<leader>|", "<cmd>vsplit<CR>", desc = "Vertical Split" },
		{ "<leader>q", smart_close, desc = "Delete window" },
		{
			"<C-h>",
			function()
				move_or_kitty("h")
			end,
			desc = "Focus on the left page",
			hidden = true,
		},
		{
			"<C-j>",
			function()
				move_or_kitty("j")
			end,
			desc = "Focus on the page below",
			hidden = true,
		},
		{
			"<C-k>",
			function()
				move_or_kitty("k")
			end,
			desc = "Focus on the page above",
			hidden = true,
		},
		{
			"<C-l>",
			function()
				move_or_kitty("l")
			end,
			desc = "Focus on the right page",
			hidden = true,
		},
		{
			{ "<A-h>", '<cmd>lua require("smart-splits").resize_left()<CR>', desc = "Window resize left" },
			{ "<A-j>", '<cmd>lua require("smart-splits").resize_down()<CR>', desc = "Window resize down" },
			{ "<A-k>", '<cmd>lua require("smart-splits").resize_up()<CR>', desc = "Window resize up" },
			{ "<A-l>", '<cmd>lua require("smart-splits").resize_right()<CR>', desc = "Window resize right" },
			{
				"<leader>H",
				'<cmd>lua require("smart-splits").swap_buf_left()<CR>',
				desc = "Window swap left",
				hidden = true,
			},
			{
				"<leader>J",
				'<cmd>lua require("smart-splits").swap_buf_down()<CR>',
				desc = "Window swap down",
				hidden = true,
			},
			{
				"<leader>K",
				'<cmd>lua require("smart-splits").swap_buf_up()<CR>',
				desc = "Window swap up",
				hidden = true,
			},
			{
				"<leader>L",
				'<cmd>lua require("smart-splits").swap_buf_right()<CR>',
				desc = "Window swap right",
				hidden = true,
			},
		},
	},
}
