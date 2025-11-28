vim.keymap.set("n", "<leader>s", "<cmd>call VSCodeNotify('workbench.action.files.save')<CR>", { noremap = true })
vim.keymap.set("n", "<leader>q", "<cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>", { noremap = true })

vim.keymap.set("n", "<leader>f", "<cmd>tabnew<Space>", { noremap = true })
-- vim.keymap.set("n", "<leader>c", "<cmd>tabclose<CR>", { noremap = true })
vim.keymap.set("n", "<leader>e", "<cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>", { noremap = true })
vim.keymap.set("n", "<leader>b", "<cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>", { noremap = true })

vim.keymap.set("n", "<leader>p", "<cmd>call VSCodeNotify('workbench.action.splitEditorDown')<CR>", { noremap = true })
vim.keymap.set("n", "<leader>v", "<cmd>call VSCodeNotify('workbench.action.splitEditorRight')<CR>", { noremap = true })

vim.keymap.set("n", "<leader>h", "<cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>", { noremap = true })
vim.keymap.set("n", "<leader>j", "<cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>", { noremap = true })
vim.keymap.set("n", "<leader>k", "<cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>", { noremap = true })
vim.keymap.set("n", "<leader>l", "<cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>", { noremap = true })
