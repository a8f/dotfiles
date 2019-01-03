syntax on
set nocompatible
set laststatus=2
set encoding=utf-8
set splitright
set splitbelow
set nu
set shiftwidth=4
set expandtab
set tabstop=4
set softtabstop=-1
set backspace=indent,eol,start
set scrolloff=4
" Keybindings
map <C-n> :NERDTreeToggle<CR>
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab> :tabnext<CR>
nnoremap <C-t> :tabnew<CR>
nnoremap <C-j> <C-f>
nnoremap <C-k> <C-b>
nnoremap <S-j> <C-d>
nnoremap <S-k> <C-u>
nmap <C-s>  <Esc>:w<CR>a
imap <C-s> :w<CR>
imap <C-z> <Esc>:u<CR>a
" Plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'valloric/youcompleteme'
Plugin 'bling/vim-airline'
Plugin 'rdnetto/YCM-Generator'
Plugin 'jiangmiao/auto-pairs'
call vundle#end()
filetype plugin indent on
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_confirm_extra_conf=0
let python_highlight_all=1
