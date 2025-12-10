local map = vim.keymap.set

vim.g.coc_global_extensions = {
	"coc-java",
	-- "coc-json",
	-- "coc-tsserver",
	-- "coc-pyright",
	-- "coc-rust-analyzer",
}

map("n", "gd", "<Plug>(coc-definition)", { silent = true })
map("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
map("n", "gi", "<Plug>(coc-implementation)", { silent = true })
map("n", "gr", "<Plug>(coc-references)", { silent = true })
map("n", "K", '<cmd>call CocActionAsync("doHover")<CR>', { silent = true })
map("i", "<Tab>", "<cmd>call coc#pum#confirm()<CR>", { desc = "Confirm Complete" })
map("i", "<A-k>", "<cmd>call coc#pum#select_prev()<CR>", { desc = "Confirm Complete" })
map("i", "<A-j>", "<cmd>call coc#pum#select_next()<CR>", { desc = "Confirm Complete" })
