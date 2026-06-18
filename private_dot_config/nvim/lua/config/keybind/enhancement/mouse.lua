return {
	{
		cond = function()
			return _G.plugin_installed("eagle.nvim")
		end,
		{ "<Tab>", "<cmd>EagleWin<CR>", desc = "Show: doc and diagnostic" },
	},
}
