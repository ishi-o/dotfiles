return {
	{
		cond = function()
			return _G.plugin_installed("codewindow.nvim")
		end,
		{
			"<leader>cmo",
			'<cmd>lua require("codewindow").open_minimap()<CR>',
			desc = "Open minimap",
		},
		{
			"<leader>cmf",
			'<cmd>lua require("codewindow").toggle_focus()<CR>',
			desc = "Toggle: minimap focus",
		},
		{
			"<leader>cmc",
			'<cmd>lua require("codewindow").close_minimap()<CR>',
			desc = "Close minimap",
		},
		{
			"<leader>cmm",
			'<cmd>lua require("codewindow").toggle_minimap()<CR>',
			desc = "Toggle: minimap",
		},
	},
}
