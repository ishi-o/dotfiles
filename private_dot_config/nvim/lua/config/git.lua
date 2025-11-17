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
		local gs = package.loaded.gitsigns

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

map("n", "<leader>gg", ":Gstatus<CR>", { desc = "Git Status" })
map("n", "<leader>gc", ":Gcommit<CR>", { desc = "Git Commit" })
map("n", "<leader>gp", ":Gpush<CR>", { desc = "Git Push" })
map("n", "<leader>gl", ":Gpull<CR>", { desc = "Git Pull" })
map("n", "<leader>gf", ":Gfetch<CR>", { desc = "Git Fetch" })

map("n", "<leader>gd", ":Gdiff<CR>", { desc = "Git Diff" })
map("n", "<leader>gb", ":Gblame<CR>", { desc = "Git Blame" })
map("n", "<leader>gh", ":Glog<CR>", { desc = "Git History" })

map("n", "<leader>gB", ":Gbranch<CR>", { desc = "Git Branch" })
map("n", "<leader>gm", ":Gmerge<CR>", { desc = "Git Merge" })

map("n", "<leader>go", ":GBrowse<CR>", { desc = "Git Browse" })
map("v", "<leader>go", ":GBrowse<CR>", { desc = "Git Browse Selection" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "fugitive",
	callback = function()
		map("n", "q", ":q<CR>", { buffer = true, desc = "Close Fugitive" })
		map("n", "<leader>q", ":q<CR>", { buffer = true, desc = "Close Fugitive" })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "gitcommit",
	callback = function()
		map("n", "<leader>gc", ":wq<CR>", { buffer = true, desc = "Save and Commit" })
		map("n", "<C-c>", ":q!<CR>", { buffer = true, desc = "Cancel Commit" })

		vim.bo.textwidth = 72
		vim.wo.colorcolumn = "50,72"
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "fugitiveblame",
	callback = function()
		map("n", "q", ":q<CR>", { buffer = true, desc = "Close Blame" })
		map("n", "<Esc>", ":q<CR>", { buffer = true, desc = "Close Blame" })
	end,
})
