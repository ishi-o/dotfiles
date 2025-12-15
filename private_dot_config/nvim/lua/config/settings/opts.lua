vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
vim.opt.encoding = "utf-8"
vim.opt.syntax = "on"
vim.opt.ruler = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.autowrite = true
vim.opt.incsearch = true
vim.opt.compatible = false
vim.opt.showmatch = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt.laststatus = 2
vim.opt.clipboard = "unnamedplus"

vim.opt.mouse = "a"
vim.opt.mousefocus = true

vim.opt.signcolumn = "yes:1"

vim.opt.showtabline = 2
vim.opt.timeoutlen = 400
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldinner: ,foldclose:"
vim.opt.foldtext =
	"v:lua.vim.fn.printf(' %s  [%d lines]', substitute(getline(v:foldstart), '\\t', repeat(' ', &tabstop), 'g'), v:foldend - v:foldstart + 1)"

vim.opt.breakindent = true
vim.opt.showbreak = "↪"
