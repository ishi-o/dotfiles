return {
	-- lazygit.nvim --
	-- lazygit integration
	-- lazygit 集成, 要求命令行工具 lazygit
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = "LazyGit",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("config.extra.git.lazygit")
		end,
	},
	-- gitsigns.nvim --
	-- git signals
	-- 左侧 git 变更提醒
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("config.extra.git.gitsigns")
		end,
	},
	-- neogit --
	-- neovim 的 git 集成
	{
		"NeogitOrg/neogit",
		lazy = true,
		cmd = "Neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("config.extra.git.neogit")
		end,
	},
	-- gh.nvim --
	-- github cli integration
	-- github 命令行工具 gh 集成
	{
		"ldelossa/gh.nvim",
		lazy = true,
		cmd = {
			"GHCloseCommit",
			"GHExpandCommit",
			"GHOpenToCommit",
			"GHPopOutCommit",
			"GHCollapseCommit",
			"GHPreviewIssue",
			"LTPanel",
			"GHClosePR",
			"GHPRDetails",
			"GHExpandPR",
			"GHOpenPR",
			"GHPopOutPR",
			"GHRefreshPR",
			"GHOpenToPR",
			"GHCollapsePR",
			"GHStartReview",
			"GHCloseReview",
			"GHDeleteReview",
			"GHExpandReview",
			"GHSubmitReview",
			"GHCollapseReview",
			"GHCreateThread",
			"GHNextThread",
			"GHToggleThread",
		},
		dependencies = {
			"ldelossa/litee.nvim",
		},
		config = function()
			require("config.extra.git.gh")
		end,
	},
}
