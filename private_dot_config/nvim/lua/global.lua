-- require("plugins")

local map = vim.api.nvim_set_keymap
map("n", "<Space>", "<Nop>", { noremap = true })

vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 1
vim.g.mkdp_refresh_slow = 0
vim.g.mkdp_echo_preview_url = 1

vim.g.mapleader = " "

vim.opt.encoding = "utf-8"
vim.opt.syntax = "on"
vim.opt.ruler = true
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.autowrite = true
vim.opt.incsearch = true
vim.opt.compatible = false
vim.opt.showmatch = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.laststatus = 2

if vim.g.vscode then
	require("config.vscode-keybinding")
else
	require("config.local-keybinding")
end
