"General config
filetype plugin indent on
syntax on
set nocompatible
set noshowmode
set laststatus=2
set splitright
set splitbelow
set number
set shiftwidth=4
set expandtab
set tabstop=4
set softtabstop=-1
set backspace=indent,eol,start
set scrolloff=4
set mouse=a
set hidden
set confirm
set completeopt-=preview
set foldmethod=indent
set foldlevelstart=2
set foldnestmax=2
set hlsearch
set incsearch
set completeopt=menuone,noselect,noinsert

augroup Spellcheck
    autocmd FileType text setlocal spell
augroup END

"Keep all folds open when a file is opened
augroup OpenAllFoldsOnFileOpen
    autocmd!
    autocmd BufRead * normal zR
augroup END

"Enable 24-bit colour (credit GitHub/joshdick)
if (empty($TMUX))
  if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has('termguicolors'))
    set termguicolors
  endif
endif

"Enter insert mode with smart indent
function! IndentA()
    if len(getline('.')) == 0
        return "\"_cc"
    else
        return 'a'
    endif
endfunction

"Go to last location when reopening file
"If this doesn't work maybe you don't have perms for ~/.viminfo?
if has('autocmd')
  augroup Resume
      au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
  augroup END
endif

"Clear search when opening new buffer
augroup ClearSearch
    autocmd bufnewfile,bufread,bufenter :let @/ = ""<CR>
augroup END

"Max line length column indicator
augroup LineLengthIndicator
    autocmd FileType python setlocal colorcolumn=88
    autocmd FileType c,cpp,java setlocal colorcolumn=120
augroup END


"Plugins


"ALE
let g:ale_fix_on_save = 1
let g:ale_set_balloons = 1
let g:ale_lint_on_changed = 'normal'
let g:ale_fixers = {'*': ['remove_trailing_lines','trim_whitespace'],
                        \'javascript': ['eslint', 'remove_trailing_lines', 'trim_whitespace'],
                        \'haskell': ['brittany', 'remove_trailing_lines', 'trim_whitespace'],
                        \'c': ['uncrustify', 'remove_trailing_lines', 'trim_whitespace'],
                        \'python': ['isort', 'black', 'trim_whitespace'],
                        \'sh': ['shfmt']}
let g:ale_linters_explicit = 1 " Only run the linters below
let g:ale_linters = {'c': ['gcc', 'clangd'],
            \'haskell': ['ghc', 'hlint'],
            \'python': ['pyls', 'flake8'],
            \'gitcommit': ['gitlint'],
            \'sh': ['shellcheck'],
            \'vim': ['vint'],
            \'javascript': ['eslint']
            \}
"Less intrusive error/warning symbol
let g:ale_sign_error = '>'
let g:ale_sign_warning = '-'
"Autocompletion
let g:ale_completion_enabled = 1
let g:ale_completion_max_suggestions = 2000
let g:ale_completion_delay = 150
let g:ale_completion_excluded_words = ['if', 'else', 'while', 'break', 'continue', 'return', 'switch', 'char', 'int', 'for', 'in']
" For some reason need this or OmniFunc gets reset for every buffer
augroup AleOmniFunc
    autocmd bufnewfile,bufread,bufenter * set omnifunc=ale#completion#OmniFunc
augroup END

"Python
"flake8 options to match Black style
let g:ale_python_flake8_options = '--max-line-length=88 --extend-ignore=E203'
"pyls for completion only
"since pyls doesn't allow settings a max line length for flake8
"without a config file, just disable it and use ALE's flake8
let g:ale_python_pyls_config = {
      \   'pyls': {
      \     'plugins': {
      \       'pycodestyle': {
      \         'enabled': v:false
      \       },
      \       'mccabe': {
      \         'enabled': v:false
      \       },
      \       'autopep8': {
      \         'enabled': v:false
      \       },
      \       'yapf': {
      \         'enabled': v:false
      \       },
      \       'rope': {
      \         'enabled': v:false
      \       },
      \       'flake8': {
      \         'enabled': v:false
      \       },
      \     }
      \   },
      \ }

"C
let g:ale_c_uncrustify_options = '-c ~/.config/uncrustify.cfg'
let g:ale_c_parse_compile_commands = 1
"Makefile after compile_commands to override
let g:ale_c_parse_makefile = 1
"No gcc options, load from makefile or compile_commands.json
let g:ale_c_gcc_options = ''

"Airline
let g:airline#extensions#ale#enabled=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#tabline#buffers_label = ''
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline_powerline_fonts = 1

"Nerdtree/Nerdcommenter
let NERDTreeQuitOnOpen=1
let g:NERDCompactSexyComs =1
let g:NERDCommentEmptyLines = 1
" Quit if nerdtree is the only thing open
augroup QuitNerdTREE
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

"Sneak
let g:sneak#s_next = 1
let g:sneak#use_ic_scs = 1
let g:sneak#label = 1

"Taglist
let Tlist_Close_On_Select = 1

"Bracket matches
let g:matchup_matchparen_offscreen = { 'method': 'popup' }
let g:matchup_matchparen_deferred = 1

"Disable polygot for latex ( use vimtex instead)
let g:polyglot_disabled = ['latex']

"Markdown preview
let g:instant_markdown_slow = 1
let g:instant_markdown_browser = 'firefox'

"ctrlsf
let g:ctrlsf_auto_focus = {
    \ 'at': 'done',
    \ 'duration_less_than': 1000
    \ }
let g:ctrlsf_default_root = 'project'
let g:ctrlsf_default_view_mode = 'compact'

"vim-multiple-cursors
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-v>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-v>'
let g:multi_cursor_select_all_key      = 'g<A-v>'
let g:multi_cursor_next_key            = '<C-v>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" Load plugins
call plug#begin()
"General plugins
Plug 'dense-analysis/ale'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0ng/vim-hybrid' "Colorscheme
Plug 'andymass/vim-matchup' "Auto-insert closing brackets/quotes
Plug 'raimondi/delimitmate' "Highlight matches for delimiters

"Navigation
Plug 'justinmk/vim-sneak'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/taglist.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'

"Language support
Plug 'sheerun/vim-polyglot'
Plug 'neovimhaskell/haskell-vim', {'on_ft': 'haskell'}
Plug 'lervag/vimtex', {'on_ft': 'tex'}

"Previewing
Plug 'xuhdev/vim-latex-live-preview', {'on_ft': 'tex'}
Plug 'suan/vim-instant-markdown', {'on_ft': 'markdown'} "needs sudo npm -g install instant-markdown-d
call plug#end()


" Colorscheme


colorscheme hybrid
set background=dark
let g:airline_theme = 'hybrid'
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
"ctrl+backspace to backspace word
inoremap <C-BS> <C-W>
"ctrl + z to undo (if environment doesn't interpret it as background)
imap <C-z> <Esc>:u<CR>a
"Leader + y to yank to system clipboard
nmap <leader>y "+y
"q instead of b for navigation
nnoremap q b
nnoremap <S-q> <S-b>
"Space for completion
inoremap <C-@> <C-X><C-O>
nnoremap <C-S-N> :NERDTreeToggle<CR>
"Buffer navigation
nnoremap <C-n> :bn<CR>
nnoremap <C-b> :bp<CR>
"When popup is visible use tab to cycle through suggestions
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<TAB>"
"Press return again to disable highlighting after searching
nnoremap <silent><CR> :noh<CR><CR>
"ALE related keybinds
nnoremap <leader>l :ALEFix<return>
nnoremap <leader>d :call ale#definition#GoTo({})<return>
nnoremap <leader>v :call ale#definition#GoTo({'open_in': 'horizontal-split'})<return>
nnoremap <leader>r :call ale#references#Find()<return>
nnoremap <buffer> <leader>q :call ale#cursor#ShowCursorDetail()<cr>
"Taglist
nnoremap <C-t> :TlistOpen<CR>
"ctrlsf
nmap  <C-x> <Plug>CtrlSFPrompt
