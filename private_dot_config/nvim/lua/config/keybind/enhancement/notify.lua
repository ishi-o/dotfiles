return {
	{
		cond = function()
			return _G.UserUtils.plugin_installed("noice.nvim")
		end,
		{
			"<leader>n",
			"<cmd>Noice snacks<CR>",
			desc = "Notification History",
		},
		{
			"<leader>fn",
			"<cmd>Noice snacks<CR>",
			desc = "Notification History",
		},
	},
}
