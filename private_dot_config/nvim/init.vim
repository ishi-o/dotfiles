let mapleader=" "

set encoding=utf-8
syntax on
set ruler
set nu
set cursorline
set autowrite
set is
set nocompatible
set showmatch
set tabstop=4
set shiftwidth=4
set noexpandtab
set laststatus=2

inoremap jj <Esc>

" save
nnoremap <Leader>s :w<CR>
" quit
nnoremap <Leader>q :wq<CR>

""" nnoremap <Leader>n :tabnew<CR>
""" nnoremap <C-t> :tabnew<CR>
" file
nnoremap <Leader>f :tabnew<Space>
" close
nnoremap <Leader>c :tabclose<CR>
nnoremap <Leader>e :tabnext<CR>
nnoremap <Leader>b :tabprevious<CR>

nnoremap <Leader>p :split<CR>
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>h <C-w> h
nnoremap <Leader>j <C-w> j
nnoremap <Leader>k <C-w> k
nnoremap <Leader>l <C-w> l
