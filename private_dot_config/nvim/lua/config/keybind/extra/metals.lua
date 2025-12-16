return {
	{
		"<leader>fm",
		'<cmd>lua require("telescope").extensions.metals.commands()<CR>',
		desc = "Metals commands",
	},
	{
		"<leader>mc",
		'<cmd>lua require("metals").compile_cascade()<CR>',
		desc = "Metals compile cascade",
	},
	{
		"<leader>mh",
		'<cmd>lua require("metals").hover_worksheet()<CR>',
		desc = "Metals hover worksheet",
	},
}
