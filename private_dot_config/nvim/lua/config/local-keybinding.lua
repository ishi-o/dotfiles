local map = vim.keymap.set

local function multi_map(modes, keys, rhs, opts)
	opts = opts or {}
	for _, key in ipairs(keys) do
		map(modes, key, rhs, opts)
	end
end

map("i", "jj", "<Esc>", { desc = "Return to normal mode" })

map("n", "<leader>s", "<cmd>w<CR>", { desc = "Save file (not !)" })

multi_map("n", { "<leader>q", "q<leader>" }, "<cmd>q<CR>", { desc = "Quit file (not !)" })

map("n", "<leader>t", ":tabnew<Space>", { desc = "NewTab (input filename)" })
-- map("n", "<leader>c", "<cmd>tabclose<CR>", { desc = "Close Tab" })
map("n", "<leader>b", "<cmd>tabprevious<CR>", { desc = "Previous Tab" })
map("n", "<leader>n", "<cmd>tabnext<CR>", { desc = "Next Tab" })

map("n", "<leader>p", ":split ", { desc = "Horizontal Split (input filename)" })
map("n", "<leader>v", ":vsplit ", { desc = "Vertical Split (input filename)" })

map("n", "<leader>h", "<cmd>wincmd h<CR>", { desc = "Focus on the left page" })
map("n", "<leader>j", "<cmd>wincmd j<CR>", { desc = "Focus on the page below" })
map("n", "<leader>k", "<cmd>wincmd k<CR>", { desc = "Focus on the page above" })
map("n", "<leader>l", "<cmd>wincmd l<CR>", { desc = "Focus on the right page" })

map("x", "<C-c>", '"+y', { desc = "Copy selected chars" })
map({ "n", "i" }, "<C-c>", '"+yy', { desc = "Copy current line" })
