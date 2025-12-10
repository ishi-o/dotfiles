return {
	-- substitude.nvim --
	-- inner substitude
	-- 文件内粘贴, 将 v obj p 优化为 prefix obj
	{
		"gbprod/substitute.nvim",
		lazy = true,
		module = "substitute",
		config = function()
			require("config.enhancement.substitute.substitute")
		end,
	},
	-- nvim-spectre --
	-- ripgrep substitude
	-- 跨文件替换, 依赖 rg 命令行工具
	{
		"nvim-pack/nvim-spectre",
		optional = true,
		lazy = true,
		module = "spectre",
		config = function()
			require("config.enhancement.substitute.spectre")
		end,
	},
	-- grup-far.nvim --
	-- ripgrep substitude
	-- 跨文件替换, 依赖 rg 命令行工具
	{
		"MagicDuck/grug-far.nvim",
		lazy = true,
		opts = { headerMaxWidth = 80 },
		cmd = { "GrugFar", "GrugFarWithin" },
		config = function()
			require("config.enhancement.substitute.grug-far")
		end,
	},
}
