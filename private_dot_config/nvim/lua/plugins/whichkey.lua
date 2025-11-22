return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			win = {
				border = "rounded",
				row = math.huge,
				col = math.huge,
				width = 0.3,
				height = 0.9,
				no_overlap = true,
			},
			max_description_length = 30,
			show = {
				delay = 600,
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
}
