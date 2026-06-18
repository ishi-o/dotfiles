return {
	{
		cond = function()
			return _G.plugin_installed("neo-tree.nvim")
		end,
		{
			"<C-e>",
			"<cmd>Neotree toggle<CR>",
			mode = { "n", "x", "i", "t" },
			desc = "Toggle: file explorer",
		},
	},
}
