return {
	{
		"stevearc/aerial.nvim",
		enabled = false,
		lazy = true,
		cmd = { "AerialToggle", "AerialPrev", "AerialNext" },
		config = function()
			require("config.langservice.outline")
		end,
	},
}
