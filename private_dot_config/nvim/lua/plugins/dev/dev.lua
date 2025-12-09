return {
	-- trouble --
	-- quick diagnostic
	{
		"folke/trouble.nvim",
		lazy = true,
		cmd = "Trouble",
		config = function()
			require("config.dev.trouble")
		end,
	},
	-- lazydev --
	-- lua dev lib
	{
		"folke/lazydev.nvim",
		lazy = true,
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "LazyVim", words = { "LazyVim" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
				{ path = "lazy.nvim", words = { "LazyVim" } },
			},
		},
	},
}
