-- code map --
return {
	-- codewindow.nvim --
	{
		"<leader>mo",
		'<cmd>lua require("codewindow").open_minimap()<CR>',
		desc = "Open minimap",
	},
	{
		"<leader>mf",
		'<cmd>lua require("codewindow").toggle_focus()<CR>',
		desc = "Toggle: minimap focus",
	},
	{
		"<leader>mc",
		'<cmd>lua require("codewindow").close_minimap()<CR>',
		desc = "Close minimap",
	},
	{
		"<leader>mm",
		'<cmd>lua require("codewindow").toggle_minimap()<CR>',
		desc = "Toggle: minimap",
	},
}
