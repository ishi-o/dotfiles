vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 1
vim.g.mkdp_refresh_slow = 0
vim.g.mkdp_echo_preview_url = 1

vim.g.mapleader = " "

vim.g.have_nerd_font = true

if vim.g.vscode then
	require("config.vscode-keybinding")
else
	require("config.local-keybinding")
end
