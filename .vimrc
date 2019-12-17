"General config
filetype plugin indent on
syntax on
set nocompatible
set noshowmode
set laststatus=2
"set encoding=utf-8
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
set completeopt-=preview
autocmd FileType text setlocal spell
set foldmethod=indent
set foldlevelstart=2
set foldnestmax=2
set hlsearch
set incsearch
set completeopt=menu,menuone,noselect,noinsert
autocmd BufRead,BufNewFile *.py let python_highlight_all=1

"Keep all folds open when a file is opened
augroup OpenAllFoldsOnFileOpen
    autocmd!
    autocmd BufRead * normal zR
augroup END

"Enable 24-bit colour (credit GitHub/joshdick)
if (empty($TMUX))
  if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

"Enter insert mode with smart indent
function! IndentA()
    if len(getline('.')) == 0
        return "\"_cc"
    else
        return "a"
    endif
endfunction

" Go to last location when reopening file
" If this doesn't work maybe you don't have perms for ~/.viminfo?
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

"Clear search when opening new buffer
autocmd bufnewfile,bufread,bufenter :let @/ = ""<CR>


"Plugins


" ALE settings
" Set before loading ALE
let g:ale_completion_enabled = 1
let g:ale_fixers = {'*': ['remove_trailing_lines','trim_whitespace'],
                        \'javascript': ['eslint'],
                        \'haskell': ['brittany'],
                        \'c': ['uncrustify'],
                        \'python': ['isort', 'autopep8']}
let g:ale_linters_explicit = 1 " Only run the linters below
let g:ale_linters = {'c': ['gcc', 'clangd'],
            \'haskell': ['ghc', 'hlint'],
            \'python': ['flake8', 'pylint', 'bandit']}
let g:ale_c_uncrustify_options = '-c ~/.config/uncrustify.cfg'
let g:ale_fix_on_save = 1
let g:ale_set_balloons = 1
let g:ale_c_parse_compile_commands = 1
" Makefile after compile_commands to override
let g:ale_c_parse_makefile = 1
" No gcc options, load from makefile or compile_commands.json
let g:ale_c_gcc_options = ''
" Less intrusive error/warning symbol
let g:ale_sign_error = '>'
let g:ale_sign_warning = '-'
" Autocompletion
let g:ale_completion_enabled = 0
let g:ale_completion_max_suggestions = 1500
let g:ale_completion_delay = 1000
let g:ale_completion_excluded_words = ['if', 'else', 'while', 'break', 'continue', 'return', 'switch', 'char', 'int', 'for', 'in']
"autocmd bufnewfile,bufread,bufenter * set omnifunc=ale#completion#OmniFunc

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
let g:NERDCommentEmptyLines = 1
" Quit if nerdtree is the only thing open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"Sneak
let g:sneak#s_next = 1
let g:sneak#use_ic_scs = 1
let g:sneak#label = 1

"Taglist
let Tlist_Close_On_Select = 1

"Bracket matches
let g:matchup_matchparen_offscreen = { 'method': 'popup' }
let g:matchup_matchparen_deferred = 1

"Deoplete
let g:deoplete#enable_at_startup = 1

let g:polyglot_disabled = ['latex']

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
Plugin 'vim-scripts/taglist.vim'
Plugin 'haya14busa/incsearch.vim'
Plugin 'justinmk/vim-sneak'
Plugin 'andymass/vim-matchup'
Plugin 'Shougo/deoplete.nvim'
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'Shougo/neoinclude.vim'
call vundle#end()

call deoplete#custom#option({
            \ 'auto_complete_delay': 250,
            \ 'smart_case': v:true,
            \ 'camel_case': v:true,
            \})



" Colorscheme


colorscheme hybrid
set background=dark
let g:airline_theme = "hybrid"
hi Normal guibg=NONE ctermbg=NONE


"Keybinds


"Auto-indent when using a
nnoremap <expr> a IndentA()
"Scroll display lines
nnoremap j gj
nnoremap k gk
"down and up with J and K
nnoremap <S-j> <C-d>
nnoremap <S-k> <C-u>
"ctrl + s to save
inoremap <C-s> <esc>:w<cr>
nnoremap <C-s> :w<cr>
"ctrl + z to undo (if environment doesn't interpret it as background)
imap <C-z> <Esc>:u<CR>a
"Leader + y to yank to system clipboard
nnoremap <leader>y "+y
" q instead of b
nnoremap q b
nnoremap <S-q> <S-b>
"Space for completion
"inoremap <C-@> <C-X><C-O>
inoremap <expr><C-@> deoplete#manual_complete()
nnoremap <C-S-N> :NERDTreeToggle<CR>
"Buffer navigation
nnoremap <C-n> :bn<CR>
nnoremap <C-b> :bp<CR>
"When popup is visible use tab to cycle through suggestions
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<TAB>"
"Press return again to disable highlighting after searching
nnoremap <silent><CR> :noh<CR><CR>
" ALE related keybinds
nnoremap <leader>l :ALEFix<return>
nnoremap <leader>d :call ale#definition#GoTo({})<return>
nnoremap <leader>v :call ale#definition#GoTo({'open_in': 'horizontal-split'})<return>
nnoremap <leader>r :call ale#references#Find()<return>
nnoremap <buffer> <leader>q :call ale#cursor#ShowCursorDetail()<cr>
"inoremap <C-@> <esc><Plug>(ale_complete)<a>
"Incsearch
"nnoremap /  <Plug>(incsearch-forward)
"nnoremap ?  <Plug>(incsearch-backward)
"nnoremap g/ <Plug>(incsearch-stay)
"Taglist
nnoremap <C-t> :TlistOpen<CR>
