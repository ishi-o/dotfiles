-- workspace --
return {
	-- project manager --
	-- project.nvim --
	{
		{ "<leader>fP", '<cmd>lua require"telescope".extensions.projects.projects{}<CR>', desc = "Projects" },
	},

	-- session manager --
	-- auto-session --
	{
		{ "<leader>fs", "<cmd>AutoSession search<CR>", desc = "Session" },
		{ "<leader>Sd", "<cmd>AutoSession delete<CR>", desc = "Delete" },
		{ "<leader>SD", "<cmd>AutoSession deletePicker<CR>", desc = "DeletePicker" },
		{ "<leader>Sr", "<cmd>AutoSession restore<CR>", desc = "Restore" },
		{ "<leader>Ss", "<cmd>AutoSession save<CR>", desc = "Save" },
	},
}
