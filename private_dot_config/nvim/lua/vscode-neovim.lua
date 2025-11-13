vim.keymap.set("n", "<Leader>s", ":call VSCodeNotify('workbench.action.files.save')<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>q", ":call VSCodeNotify('workbench.action.closeActiveEditor')<CR>",
{ noremap = true })

vim.keymap.set("n", "<Leader>f", ":tabnew<Space>", { noremap = true })
-- vim.keymap.set("n", "<Leader>c", ":tabclose<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>e", ":call VSCodeNotify('workbench.action.nextEditor')<CR>",
{ noremap = true })
vim.keymap.set("n", "<Leader>b", ":call VSCodeNotify('workbench.action.previousEditor')<CR>",
{ noremap = true })

vim.keymap.set("n", "<Leader>p", ":call VSCodeNotify('workbench.action.splitEditorDown')<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>v", ":call VSCodeNotify('workbench.action.splitEditorRight')<CR>", { noremap = true })

vim.keymap.set("n", "<Leader>h", ":call VSCodeNotify('workbench.action.focusLeftGroup')<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>j", ":call VSCodeNotify('workbench.action.focusBelowGroup')<CR>",
{ noremap = true })
vim.keymap.set("n", "<Leader>k", ":call VSCodeNotify('workbench.action.focusAboveGroup')<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>l", ":call VSCodeNotify('workbench.action.focusRightGroup')<CR>", { noremap = true })
