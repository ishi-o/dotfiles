vim.keymap.set("i", "jj", "<Esc>", { noremap = true })

vim.keymap.set("n", "<Leader>s", ":w<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>q", ":q<CR>", { noremap = true })

vim.keymap.set("n", "<Leader>f", ":tabnew<Space>", { noremap = true })
vim.keymap.set("n", "<Leader>c", ":tabclose<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>e", ":tabnext<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>b", ":tabprevious<CR>", { noremap = true })

vim.keymap.set("n", "<Leader>p", ":split ", { noremap = true })
vim.keymap.set("n", "<Leader>v", ":vsplit ", { noremap = true })

vim.keymap.set("n", "<Leader>h", ":wincmd h<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>j", ":wincmd j<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>k", ":wincmd k<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>l", ":wincmd l<CR>", { noremap = true })
