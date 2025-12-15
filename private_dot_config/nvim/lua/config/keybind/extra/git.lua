-- git / github --
return {
	{
		{ "<leader>gg", "<cmd>Neogit<CR>", desc = "Show: Neogit UI" },

		{ "<leader>ghcc", "<cmd>GHCloseCommit<CR>", desc = "Close" },
		{ "<leader>ghce", "<cmd>GHExpandCommit<CR>", desc = "Expand" },
		{ "<leader>ghco", "<cmd>GHOpenToCommit<CR>", desc = "Open To" },
		{ "<leader>ghcp", "<cmd>GHPopOutCommit<CR>", desc = "Pop Out" },
		{ "<leader>ghcz", "<cmd>GHCollapseCommit<CR>", desc = "Collapse" },

		{ "<leader>ghip", "<cmd>GHPreviewIssue<CR>", desc = "Preview" },

		{ "<leader>ghlt", "<cmd>LTPanel<CR>", desc = "Toggle: Panel" },

		{ "<leader>ghpc", "<cmd>GHClosePR<CR>", desc = "Close" },
		{ "<leader>ghpd", "<cmd>GHPRDetails<CR>", desc = "Details" },
		{ "<leader>ghpe", "<cmd>GHExpandPR<CR>", desc = "Expand" },
		{ "<leader>ghpo", "<cmd>GHOpenPR<CR>", desc = "Open" },
		{ "<leader>ghpp", "<cmd>GHPopOutPR<CR>", desc = "PopOut" },
		{ "<leader>ghpr", "<cmd>GHRefreshPR<CR>", desc = "Refresh" },
		{ "<leader>ghpt", "<cmd>GHOpenToPR<CR>", desc = "Open To" },
		{ "<leader>ghpz", "<cmd>GHCollapsePR<CR>", desc = "Collapse" },

		{ "<leader>ghrb", "<cmd>GHStartReview<CR>", desc = "Begin" },
		{ "<leader>ghrc", "<cmd>GHCloseReview<CR>", desc = "Close" },
		{ "<leader>ghrd", "<cmd>GHDeleteReview<CR>", desc = "Delete" },
		{ "<leader>ghre", "<cmd>GHExpandReview<CR>", desc = "Expand" },
		{ "<leader>ghrs", "<cmd>GHSubmitReview<CR>", desc = "Submit" },
		{ "<leader>ghrz", "<cmd>GHCollapseReview<CR>", desc = "Collapse" },

		{ "<leader>ghtc", "<cmd>GHCreateThread<CR>", desc = "Create" },
		{ "<leader>ghtn", "<cmd>GHNextThread<CR>", desc = "Next" },
		{ "<leader>ghtt", "<cmd>GHToggleThread<CR>", desc = "Toggle:" },
	},
}
