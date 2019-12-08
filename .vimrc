"General config
filetype plugin indent on
syntax on
set nocompatible
set noshowmode
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
set autoindent
set hidden
set confirm
let python_highlight_all=1
autocmd FileType text setlocal spell
"Enable 24-bit colour (credit GitHub/joshdick)
if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif


"Keybinds


"Scroll display lines
nnoremap j gj
nnoremap k gk
" down and up with J and K
nnoremap <S-j> <C-d>
nnoremap <S-k> <C-u>
" ctrl + s to save
inoremap <C-s> <esc>:w<cr>
nnoremap <C-s> :w<cr>
" ctrl + z to undo (if environment doesn't interpret it as background)
imap <C-z> <Esc>:u<CR>a
" Leader + y to yank to system clipboard
nnoremap <leader>y "+y
" Space for completion
inoremap <Nul> <C-x><C-o>
map <C-N> :NERDTreeToggle<CR>


"Plugins


" ALE settings
" Set before loading ALE
let g:ale_completion_enabled = 1
let g:ale_set_balloons = 1
set omnifunc=ale#completion#OmniFunc
let g:ale_fixers = {'*': ['remove_trailing_lines','trim_whitespace'],
                        \'javascript': ['eslint'],
                        \'haskell': ['brittany']}
" Only run linters listed below
let g:ale_linters_explicit = 1
let g:ale_linters = {'c': ['gcc', 'clangd']}
let g:ale_c_parse_compile_commands = 1
" Makefile after compile_commands to override
let g:ale_c_parse_makefile = 1
" No gcc options, load from makefile or compile_commands.json
let g:ale_c_gcc_options = ''
" Less intrusive error/warning symbol
let g:ale_sign_error = '>'
let g:ale_sign_warning = '-'
" Autocompletion
let g:ale_completion_enabled = 1
let g:ale_completion_max_suggestions = 50
let g:ale_completion_delay = 3
let g:ale_completion_excluded_words = ['if', 'else', 'while', 'break', 'continue', 'return', 'switch', 'char', 'int']
" ALE related keybinds
nnoremap <leader>l :ALEFix<return>
nnoremap <leader>d :call ale#definition#GoTo({'open_in': 'horizontal-split'})<return>
nnoremap <leader>z :call ale#definition#GoTo({})<return>
nnoremap <leader>r :call ale#references#Find()<return>
nnoremap <buffer> <leader>q :call ale#cursor#ShowCursorDetail()<cr>

" Airline settings
let g:airline#extensions#ale#enabled=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#tabline#buffers_label = ''
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline_powerline_fonts = 1

" Nerdtree/Nerdcommenter settings
let NERDTreeQuitOnOpen=1
let g:NERDCompactSexyComs =1
" Quit if nerdtree is the only thing open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Load Vundle + plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'jiangmiao/auto-pairs'
Plugin 'lervag/vimtex'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'scrooloose/nerdcommenter'
Plugin 'neovimhaskell/haskell-vim'
Plugin 'dense-analysis/ale'
Plugin 'sheerun/vim-polyglot'
Plugin 'w0ng/vim-hybrid'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
"Plugin 'tpope/vim-sleuth'
call vundle#end()


" Colorscheme


colorscheme hybrid
set background=dark
let g:airline_theme = "hybrid"
hi Normal guibg=NONE ctermbg=NONE
