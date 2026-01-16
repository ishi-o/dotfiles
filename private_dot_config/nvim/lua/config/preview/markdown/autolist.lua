require("autolist").setup()

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function(args)
		local bufnr = args.buf
		local map = vim.keymap.set

		map("i", "<CR>", "<CR><cmd>AutolistNewBullet<CR>", { buffer = bufnr, desc = "New line with bullet" })
		map("n", "o", "o<cmd>AutolistNewBullet<CR>", { buffer = bufnr, desc = "New line with bullet" })
		map("n", "O", "O<cmd>AutolistNewBulletBefore<CR>", { buffer = bufnr, desc = "New line with bullet" })
		map("n", "<CR>", "<cmd>AutolistToggleCheckbox<CR><CR>", { buffer = bufnr, desc = "New line with bullet" })
		-- map("n", "<C-r>", "<cmd>AutolistRecalculate<CR>", { buffer = bufnr, desc = "Recalculate markdown list nbr" })

		map("n", "<leader>cn", require("autolist").cycle_next_dr, { buffer = bufnr, expr = true })
		map("n", "<leader>cp", require("autolist").cycle_prev_dr, { buffer = bufnr, expr = true })

		map("n", ">>", ">><cmd>AutolistRecalculate<CR>", { buffer = bufnr, desc = "Recalculate list nbr when >>" })
		map("n", "<<", "<<<cmd>AutolistRecalculate<CR>", { buffer = bufnr, desc = "Recalculate list nbr when <<" })
		map("n", "dd", "dd<cmd>AutolistRecalculate<CR>", { buffer = bufnr, desc = "Recalculate list nbr when dd" })
		map("v", "d", "d<cmd>AutolistRecalculate<CR>", { buffer = bufnr, desc = "Recalculate list nbr when d" })
	end,
})
