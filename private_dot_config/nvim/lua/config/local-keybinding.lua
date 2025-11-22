local map = vim.keymap.set
map("i", "jj", "<Esc>", { noremap = true })

map("n", "<leader>s", ":w<CR>", { noremap = true })

map("n", "<leader>q", ":q<CR>", { noremap = true })
map("n", "q<leader>", ":q<CR>", { noremap = true })

map("n", "<leader>f", ":tabnew<Space>", { noremap = true })
map("n", "<leader>c", ":tabclose<CR>", { noremap = true })
map("n", "<leader>e", ":tabnext<CR>", { noremap = true })
map("n", "<leader>b", ":tabprevious<CR>", { noremap = true })

map("n", "<leader>p", ":split ", { noremap = true })
map("n", "<leader>v", ":vsplit ", { noremap = true })

map("n", "<leader>h", ":wincmd h<CR>", { noremap = true })
map("n", "<leader>j", ":wincmd j<CR>", { noremap = true })
map("n", "<leader>k", ":wincmd k<CR>", { noremap = true })
map("n", "<leader>l", ":wincmd l<CR>", { noremap = true })

map({ "x", "v" }, "<C-c>", '"+y', { noremap = true })
map({ "n", "i" }, "<C-c>", '"+yy', { noremap = true })
