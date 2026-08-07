return {
	{
		{ "<leader>gg", "<cmd>Neogit<CR>", desc = "Show: neogit ui" },
		{
			"<leader>gD",
			function()
				local absolute_file = vim.api.nvim_buf_get_name(0)
				if absolute_file == "" or vim.bo.buftype ~= "" then
					vim.notify("Current buffer is not a file", vim.log.levels.WARN)
					return
				end

				local file = vim.fn.fnamemodify(absolute_file, ":.")
				local branches = vim.fn.systemlist({
					"git",
					"-C",
					vim.fn.fnamemodify(absolute_file, ":h"),
					"branch",
					"--all",
					"--format=%(refname:short)",
				})
				vim.ui.select(branches, {
					prompt = "Diff current file against branch: ",
				}, function(branch)
					branch = branch and vim.trim(branch)
					if not branch or branch == "" then
						return
					end

					require("diffview").open({ branch, "--", file })
				end)
			end,
			desc = "Diff file against branch",
		},
		{ "<leader>ghcc", "<cmd>GHCloseCommit<CR>", desc = "Close" },
		{ "<leader>ghce", "<cmd>GHExpandCommit<CR>", desc = "Expand" },
		{ "<leader>ghco", "<cmd>GHOpenToCommit<CR>", desc = "Open to" },
		{ "<leader>ghcp", "<cmd>GHPopOutCommit<CR>", desc = "Pop out" },
		{ "<leader>ghcz", "<cmd>GHCollapseCommit<CR>", desc = "Collapse" },
		{ "<leader>ghip", "<cmd>GHPreviewIssue<CR>", desc = "Preview" },
		{ "<leader>ghlt", "<cmd>LTPanel<CR>", desc = "Toggle: panel" },
		{ "<leader>ghpc", "<cmd>GHClosePR<CR>", desc = "Close" },
		{ "<leader>ghpd", "<cmd>GHPRDetails<CR>", desc = "Details" },
		{ "<leader>ghpe", "<cmd>GHExpandPR<CR>", desc = "Expand" },
		{ "<leader>ghpo", "<cmd>GHOpenPR<CR>", desc = "Open" },
		{ "<leader>ghpp", "<cmd>GHPopOutPR<CR>", desc = "PopOut" },
		{ "<leader>ghpr", "<cmd>GHRefreshPR<CR>", desc = "Refresh" },
		{ "<leader>ghpt", "<cmd>GHOpenToPR<CR>", desc = "Open to" },
		{ "<leader>ghpz", "<cmd>GHCollapsePR<CR>", desc = "Collapse" },
		{ "<leader>ghrb", "<cmd>GHStartReview<CR>", desc = "Begin" },
		{ "<leader>ghrc", "<cmd>GHCloseReview<CR>", desc = "Close" },
		{ "<leader>ghrd", "<cmd>GHDeleteReview<CR>", desc = "Delete" },
		{ "<leader>ghre", "<cmd>GHExpandReview<CR>", desc = "Expand" },
		{ "<leader>ghrs", "<cmd>GHSubmitReview<CR>", desc = "Submit" },
		{ "<leader>ghrz", "<cmd>GHCollapseReview<CR>", desc = "Collapse" },
		{ "<leader>ghtc", "<cmd>GHCreateThread<CR>", desc = "Create" },
		{ "<leader>ghtn", "<cmd>GHNextThread<CR>", desc = "Next" },
		{ "<leader>ghtt", "<cmd>GHToggleThread<CR>", desc = "Toggle thread" },
		{
			{ "[h", "<cmd>Gitsigns prev_hunk<CR>", desc = "Prev hunk" },
			{ "]h", "<cmd>Gitsigns next_hunk<CR>", desc = "Next hunk" },
			{ "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", mode = { "n", "x" }, desc = "Stage hunk" },
			{ "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", mode = { "n", "x" }, desc = "Reset hunk" },
			{ "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>", desc = "Stage buffer" },
			{ "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>", desc = "Reset buffer" },
			{ "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>", desc = "Undo stage hunk" },
			{ "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", desc = "Preview hunk" },
			{ "<leader>hb", '<cmd>lua require("gitsigns").blame_line({ full = true })<CR>', desc = "Blame line" },
			{ "<leader>hB", "<cmd>Gitsigns blame<CR>", desc = "Blame buffer" },
			{ "<leader>hd", "<cmd>Gitsigns diffthis<CR>", desc = "Diff this" },
			{ "<leader>hD", '<cmd>lua require("gitsigns").diffthis("~")<CR>', desc = "Diff line ~" },
			{ "ih", ":<C-u>Gitsigns select_hunk<CR>", mode = { "o", "x" }, desc = "GitSigns Select Hunk" },
		},
	},
}
