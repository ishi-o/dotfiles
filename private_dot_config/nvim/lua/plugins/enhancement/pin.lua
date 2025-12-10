return {
	-- harpoon(2) --
	-- pin file
	-- 置顶一些文件
	{
		"ThePrimeagen/harpoon",
		lazy = true,
		cmd = "Telescope harpoon marks",
		module = "harpoon",
		branch = "harpoon2",
		config = function()
			require("config.enhancement.pin")
		end,
	},
}
