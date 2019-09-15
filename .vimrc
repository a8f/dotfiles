filetype plugin indent on
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
set mouse=a
" Keybindings
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab> :tabnext<CR>
nnoremap <C-t> :tabnew<CR>
nnoremap <C-j> <C-f>
nnoremap <C-k> <C-b>
nnoremap <S-j> <C-d>
nnoremap <S-k> <C-u>
nmap <C-s>  :w<CR>
imap <C-s> <Esc>:w<CR>a
imap <C-z> <Esc>:u<CR>a
" Plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'valloric/youcompleteme'
Plugin 'vim-airline/vim-airline'
Plugin 'rdnetto/YCM-Generator'
Plugin 'jiangmiao/auto-pairs'
Plugin 'lervag/vimtex'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'scrooloose/nerdcommenter'
Plugin 'neovimhaskell/haskell-vim'
Plugin 'dense-analysis/ale'
call vundle#end()
let g:airline#extensions#ale#enabled = 1
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_confirm_extra_conf=0
let python_highlight_all=1
let g:NERDCompactSexyComs = 1


nnoremap <Leader>ht :GhcModType<cr>
nnoremap <Leader>htc :GhcModTypeClear<cr>
autocmd FileType haskell nnoremap <buffer> <leader>? :call ale#cursor#ShowCursorDetail()<cr>


