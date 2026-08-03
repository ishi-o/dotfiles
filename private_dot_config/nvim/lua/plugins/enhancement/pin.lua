return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		lazy = true,
		cmd = "Lua Snacks.picker('harpoon')",
		module = "harpoon",
		config = function()
			require("config.enhancement.pin")
		end,
	},
}
