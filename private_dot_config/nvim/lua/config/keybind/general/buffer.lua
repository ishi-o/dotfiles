local function smart_bd()
	local buf = vim.api.nvim_get_current_buf()
	local win = vim.api.nvim_get_current_win()

	if vim.bo[buf].buftype == "terminal" then
		vim.api.nvim_buf_delete(buf, { force = true })
		return
	end

	local bufs = vim.api.nvim_list_bufs()
	local valid_bufs = {}
	for _, b in ipairs(bufs) do
		if vim.api.nvim_buf_is_loaded(b) and vim.bo[b].buflisted then
			table.insert(valid_bufs, b)
		end
	end

	local next_buf = nil
	for i, b in ipairs(valid_bufs) do
		if b == buf then
			next_buf = valid_bufs[i % #valid_bufs + 1]
			break
		end
	end

	if not next_buf then
		vim.cmd("enew")
		vim.api.nvim_buf_delete(buf, {})
	else
		vim.api.nvim_win_set_buf(win, next_buf)
		vim.api.nvim_buf_delete(buf, {})
	end
end

return {
	{
		{
			"<leader>ee",
			function()
				vim.ui.input({ prompt = "Edit file: ", completion = "file" }, function(filename)
					if filename == nil then
						return
					end
					if filename == "" then
						vim.cmd.enew()
						return
					end
					vim.api.nvim_cmd({
						cmd = "edit",
						args = { filename },
					}, {})
				end)
			end,
			desc = "New buffer (input filename)",
		},
		{ "<leader>en", "<cmd>enew<CR>", desc = "New file" },
		{ "[b", "<cmd>bprev<CR>", desc = "Goto: prev buffer" },
		{ "]b", "<cmd>bnext<CR>", desc = "Goto: next buffer" },
		{ "<leader>bl", "<cmd>b#<CR>", desc = "Goto: last buffer" },
		{ "<leader>bd", smart_bd, desc = "Delete curr buffer" },
		{
			"<leader>bC",
			function()
				vim.fn.setreg("+", vim.fn.expand("%:p"))
			end,
			desc = "Copy curr buffer absolute path",
		},
		{
			"<leader>bc",
			function()
				vim.fn.setreg("+", vim.fn.expand("%:~:."))
			end,
			desc = "Copy curr buffer relative path",
		},
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
	},
}
