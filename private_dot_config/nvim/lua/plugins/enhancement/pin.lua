return {
	-- harpoon(2) --
	-- pin file
	-- 置顶一些文件
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		lazy = true,
		cmd = "Telescope harpoon marks",
		module = "harpoon",
		config = function()
			require("config.enhancement.pin")
		end,
	},
}
