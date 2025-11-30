local map = vim.keymap.set

require("gitsigns").setup({
	signs = {
		add = { text = "│" },
		change = { text = "│" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	on_attach = function(bufnr)
		local gs = require("gitsigns")

		map("n", "]h", gs.next_hunk, { buffer = bufnr, desc = "Next Hunk" })
		map("n", "[h", gs.prev_hunk, { buffer = bufnr, desc = "Prev Hunk" })

		map("n", "<leader>hs", gs.stage_hunk, { buffer = bufnr, desc = "Stage Hunk" })
		map("n", "<leader>hr", gs.reset_hunk, { buffer = bufnr, desc = "Reset Hunk" })
		map("v", "<leader>hs", function()
			gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { buffer = bufnr, desc = "Stage Hunk" })
		map("v", "<leader>hr", function()
			gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { buffer = bufnr, desc = "Reset Hunk" })

		map("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "Preview Hunk" })
		map("n", "<leader>hb", function()
			gs.blame_line({ full = true })
		end, { buffer = bufnr, desc = "Blame Line" })
	end,
})
