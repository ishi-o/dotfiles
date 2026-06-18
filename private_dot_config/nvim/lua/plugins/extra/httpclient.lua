return {
	{
		"mistweaverco/kulala.nvim",
		enabled = false,
		ft = { "http", "rest" },
		opts = {
			global_keymaps = false,
			global_keymaps_prefix = "<leader>R",
			kulala_keymaps_prefix = "",
		},
		config = function()
			require("config.extra.httpclient")
		end,
	},
}
