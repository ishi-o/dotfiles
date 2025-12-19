-- buffer --
return {
	-- buffer locally --
	{
		{
			"<leader>ee",
			function()
				vim.api.nvim_feedkeys(":", "n", false)
				vim.defer_fn(function()
					vim.api.nvim_feedkeys("edit ", "n", false)
				end, 50)
			end,
			desc = "New buffer (input filename)",
		},
		{ "<leader>en", "<cmd>enew<CR>", desc = "New file" },
		{ "[b", "<cmd>bprev<CR>", desc = "Goto: prev buffer" },
		{ "]b", "<cmd>bnext<CR>", desc = "Goto: next buffer" },
		{ "<leader>bl", "<cmd>b#<CR>", desc = "Goto: last buffer" },
		-- buffer delete --
		{ "<leader>bd", "<cmd>bd<CR>", desc = "Delete curr buffer" },
	},

	-- buffer enhancement --
	{
		{ "[B", "<cmd>BufferLineMovePrev<CR>", desc = "Move buffer left" },
		{ "]B", "<cmd>BufferLineMoveNext<CR>", desc = "Move buffer right" },
		{ "H", "<cmd>BufferLineCyclePrev<CR>", desc = "Goto: prev buffer" },
		{ "L", "<cmd>BufferLineCycleNext<CR>", desc = "Goto: next buffer" },
		{ "<leader>bH", "<cmd>BufferLineCloseLeft<CR>", desc = "Delete left buffers" },
		{ "<leader>bL", "<cmd>BufferLineCloseRight<CR>", desc = "Delete right buffers" },
		{ "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
		{ "<leader>bp", "<cmd>BufferLineTogglePin<CR>", desc = "Toggle: buffer pin" },
		{ "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete unpinned buffers" },
		{ "<leader>bs", "<cmd>BufferLinePick<CR>", desc = "Select buffer" },
	},
}
