set nocompatible
set laststatus=2
set encoding=utf-8
set splitright
set splitbelow
syntax on
filetype off
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
set nu
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
nnoremap <C-j>      <C-f>
nnoremap <C-k>      <C-b>
nnoremap <S-j>     <C-d>
nnoremap <S-k>     <C-u>
set shiftwidth=4
set expandtab
set tabstop=4
set softtabstop=-1
set backspace=indent,eol,start
set scrolloff=4
