return {
	{
		"mikesmithgh/kitty-scrollback.nvim",
		lazy = true,
		cmd = {
			"KittyScrollbackGenerateKittens",
			"KittyScrollbackCheckHealth",
			"KittyScrollbackGenerateCommandLineEditing",
		},
		event = { "User KittyScrollbackLaunch" },
		config = function()
			require("config.extra.kitty")
		end,
	},
}
