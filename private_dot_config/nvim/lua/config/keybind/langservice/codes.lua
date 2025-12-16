return {
	-- documentation --
	{
		"<leader>cd",
		'<cmd>lua require("neogen").generate()<CR>',
		desc = "Generate documentation",
	},
	{ "<leader>cc", desc = "Code actions" },
	{ "<leader>C", desc = "Code actions" },
	{ "<leader>cr", desc = "Rename" },

	{ "<leader>fv", desc = "Find python envs" },
}
