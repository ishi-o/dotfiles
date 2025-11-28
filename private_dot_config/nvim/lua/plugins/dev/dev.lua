return {
	-- trouble --
	-- quick diagnostic
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		lazy = false,
		config = function()
			require("config.dev.trouble")
		end,
	},
	-- lazydev --
	-- lua dev lib
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}
