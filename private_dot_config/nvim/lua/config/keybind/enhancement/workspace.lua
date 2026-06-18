return {
	{
		cond = function()
			return _G.plugin_installed("auto-session")
		end,
		{ "<leader>fs", "<cmd>AutoSession search<CR>", desc = "Session" },
		{ "<leader>Sd", "<cmd>AutoSession delete<CR>", desc = "Delete" },
		{ "<leader>SD", "<cmd>AutoSession deletePicker<CR>", desc = "DeletePicker" },
		{ "<leader>Sr", "<cmd>AutoSession restore<CR>", desc = "Restore" },
		{ "<leader>Ss", "<cmd>AutoSession save<CR>", desc = "Save" },
	},
}
