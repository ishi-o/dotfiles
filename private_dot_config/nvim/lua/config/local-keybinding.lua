vim.keymap.set("i", "jj", "<Esc>", { noremap = true })

vim.keymap.set("n", "<leader>s", function() 
	vim.lsp.buf.format({ async = false })
	vim.cmd("w")
end, { noremap = true })

vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true })
vim.keymap.set("n", "q<leader>", ":q<CR>", { noremap = true })

vim.keymap.set("n", "<leader>f", ":tabnew<Space>", { noremap = true })
vim.keymap.set("n", "<leader>c", ":tabclose<CR>", { noremap = true })
vim.keymap.set("n", "<leader>e", ":tabnext<CR>", { noremap = true })
vim.keymap.set("n", "<leader>b", ":tabprevious<CR>", { noremap = true })

vim.keymap.set("n", "<leader>p", ":split ", { noremap = true })
vim.keymap.set("n", "<leader>v", ":vsplit ", { noremap = true })

vim.keymap.set("n", "<leader>h", ":wincmd h<CR>", { noremap = true })
vim.keymap.set("n", "<leader>j", ":wincmd j<CR>", { noremap = true })
vim.keymap.set("n", "<leader>k", ":wincmd k<CR>", { noremap = true })
vim.keymap.set("n", "<leader>l", ":wincmd l<CR>", { noremap = true })

vim.keymap.set({ "x", "v" }, "<C-c>", "\"+y", { noremap = true })
