filetype plugin indent on
syntax on
set nocompatible
set noshowmode
set laststatus=2
set encoding=utf-8
set splitright
set splitbelow
set nu
"set shiftwidth=4
"set expandtab
set tabstop=4
set softtabstop=-1
set backspace=indent,eol,start
set scrolloff=4
set mouse=a

" Keybindings
" Scroll display lines
nnoremap j gj
nnoremap k gk
"cycle tabs with ctrl like firefox
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab> :tabnext<CR>
" down and up with J and K
nnoremap <S-j> <C-d>
nnoremap <S-k> <C-u>
" ctrl + s to save
inoremap <C-s> <esc>:w<cr>
nnoremap <C-s> :w<cr>
" ctrl + z to undo (if environment doesn't interpret it as background)
imap <C-z> <Esc>:u<CR>a
nnoremap <Leader>ht :GhcModType<cr>
nnoremap <Leader>htc :GhcModTypeClear<cr>

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
Plugin 'tpope/vim-sleuth'
Plugin 'isthisnagee/vim-488', { 'for': '488' }
call vundle#end()
let g:airline#extensions#ale#enabled=1
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_confirm_extra_conf=0
let python_highlight_all=1
let g:NERDCompactSexyComs =1
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'],'javascript': ['eslint'],'haskell': ['hindent']}


" Autocmds
autocmd FileType haskell nnoremap <buffer> <leader>? :call ale#cursor#ShowCursorDetail()<cr>
autocmd BufNewFile,BufRead *.488 set filetype=488
autocmd BufNewFile,BufRead *.cup set filetype=cup
autocmd FileType text setlocal spell
