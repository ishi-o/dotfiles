return {
	{
		"kdheepak/lazygit.nvim",
		enabled = false,
		lazy = true,
		cmd = "LazyGit",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("config.extra.git.lazygit")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("config.extra.git.gitsigns")
		end,
	},
	{
		"NeogitOrg/neogit",
		lazy = true,
		cmd = "Neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
		},
		config = function()
			require("config.extra.git.neogit")
		end,
	},
	{
		"ldelossa/gh.nvim",
		enabled = false,
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
	{
		"pwntester/octo.nvim",
		enabled = false,
		cmd = "Octo",
		event = { { event = "BufReadCmd", pattern = "octo://*" } },
		opts = {
			enable_builtin = true,
			default_to_projects_v2 = true,
			default_merge_method = "squash",
			picker = "telescope",
		},
		keys = {
			{ "<leader>gi", "<cmd>Octo issue list<CR>", desc = "List Issues (Octo)" },
			{ "<leader>gI", "<cmd>Octo issue search<CR>", desc = "Search Issues (Octo)" },
			{ "<leader>gp", "<cmd>Octo pr list<CR>", desc = "List PRs (Octo)" },
			{ "<leader>gP", "<cmd>Octo pr search<CR>", desc = "Search PRs (Octo)" },
			{ "<leader>gr", "<cmd>Octo repo list<CR>", desc = "List Repos (Octo)" },
			{ "<leader>gS", "<cmd>Octo search<CR>", desc = "Search (Octo)" },
			{ "<localleader>a", "", desc = "+assignee (Octo)", ft = "octo" },
			{ "<localleader>c", "", desc = "+comment/code (Octo)", ft = "octo" },
			{ "<localleader>l", "", desc = "+label (Octo)", ft = "octo" },
			{ "<localleader>i", "", desc = "+issue (Octo)", ft = "octo" },
			{ "<localleader>r", "", desc = "+react (Octo)", ft = "octo" },
			{ "<localleader>p", "", desc = "+pr (Octo)", ft = "octo" },
			{ "<localleader>pr", "", desc = "+rebase (Octo)", ft = "octo" },
			{ "<localleader>ps", "", desc = "+squash (Octo)", ft = "octo" },
			{ "<localleader>v", "", desc = "+review (Octo)", ft = "octo" },
			{ "<localleader>g", "", desc = "+goto_issue (Octo)", ft = "octo" },
			{ "@", "@<C-x><C-o>", mode = "i", ft = "octo", silent = true },
			{ "#", "#<C-x><C-o>", mode = "i", ft = "octo", silent = true },
		},
	},
}
