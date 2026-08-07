return {
	{
		{
			"<leader><tab><tab>",
			function()
				vim.ui.input({ prompt = "New tab file: " }, function(filename)
					if filename == nil then
						return
					end
					vim.api.nvim_cmd({
						cmd = "tabnew",
						args = filename == "" and {} or { filename },
					}, {})
				end)
			end,
			desc = "NewTab (input filename)",
		},
		{ "[<tab>", "<cmd>tabprevious<CR>", desc = "Previous tab" },
		{ "]<tab>", "<cmd>tabnext<CR>", desc = "Next tab" },
		{ "<leader><tab>d", "<cmd>tabclose<CR>", desc = "Delete tab" },
		{
			"<leader><tab>r",
			function()
				vim.ui.input({ prompt = "Tab name: " }, function(name)
					if name == nil or name == "" then
						return
					end
					vim.api.nvim_cmd({
						cmd = "BufferLineTabRename",
						args = { name },
					}, {})
				end)
			end,
			desc = "Rename",
		},
	},
}
