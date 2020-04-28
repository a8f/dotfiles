"************************************"
"************************************"
"********** General config **********"
"************************************"
"************************************"

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
"Save persistent undo in ~/.vim/undo
set undofile
set undodir=~/.vim/undo
set signcolumn=yes

"Enable spellcheck
augroup Spellcheck
    autocmd FileType text setlocal spell
    autocmd FileType tex setlocal spell
augroup END

"Keep all folds open when a file is opened
augroup OpenAllFoldsOnFileOpen
    autocmd!
    autocmd BufRead * normal zR
augroup END

"Enable 24-bit colour
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
    autocmd FileType c,cpp,java,javascript,javascriptreact setlocal colorcolumn=120
augroup END

"Delete trailing whitespace on lines
function! <SID>StripTrailingWhitespaces()
  " save cursor location to return to later
  let _s=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let @/=_s
  call cursor(l, c)
endfunction

autocmd BufWritePre * call <SID>StripTrailingWhitespaces()


"***********************************"
"***********************************"
"********** Plugin config **********"
"***********************************"
"***********************************"


"Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#tabline#buffers_label = ''
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#coc#enabled = 1
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

"vim-latex-live-preview
let g:livepreview_cursorhold_recompile = 0

"Highlight symbol under cursor on CursorHold
au CursorHold * sil call CocActionAsync('highlight')
au CursorHoldI * sil call CocActionAsync('showSignatureHelp')

"incsearch.vim
let g:incsearch#auto_nohlsearch = 1

"indentline
let g:indentLine_char = '▏'
"let g:indentLine_setConceal = 0


"**********************************"
"**********************************"
"********** Load plugins **********"
"**********************************"
"**********************************"


"Install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Load plugins
call plug#begin()
Plug 'tpope/vim-repeat' "Allow repeat for plugin commands

"Code completion/linting
Plug 'andymass/vim-matchup' "Highlight matching brackets
Plug 'neoclide/coc.nvim'
"After installing coc do :call coc#util#install() then CocInstall
"coc-python, coc-ccls, coc-tsserver, coc-html, coc-json, coc-eslint,
"coc-snippets, coc-java, etc.
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'

"Interface
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0ng/vim-hybrid' "Colorscheme
Plug 'yggdroot/indentline'
Plug 'raimondi/delimitmate' "Highlight matches for delimiters

"Navigation
Plug 'justinmk/vim-sneak'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/taglist.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'haya14busa/incsearch.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"Language support
Plug 'sheerun/vim-polyglot'
Plug 'neovimhaskell/haskell-vim', {'on_ft': 'haskell'}
Plug 'lervag/vimtex', {'on_ft': 'tex'}
Plug 'goerz/jupytext.vim'

"Previewing
Plug 'xuhdev/vim-latex-live-preview', {'on_ft': 'tex'}
Plug 'suan/vim-instant-markdown', {'on_ft': 'markdown'} "needs sudo npm -g install instant-markdown-d
call plug#end()


"*********************************"
"*********************************"
"********** Colorscheme **********"
"*********************************"
"*********************************"


colorscheme hybrid
set background=dark
let g:airline_theme = 'hybrid'
hi Normal guibg=NONE ctermbg=NONE


"******************************"
"******************************"
"********** Keybinds **********"
"******************************"
"******************************"


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
"nnoremap q b
"nnoremap <S-q> <S-b>
"Buffer navigation
nnoremap <C-m> :bn<CR>
nnoremap <C-n> :bp<CR>
"delete next word
imap <C-q> <C-O>dw

"Space for completion
"inoremap <C-@> <C-X><C-O>
inoremap <silent><expr> <C-@> coc#refresh()
nmap = :NERDTreeToggle<CR>
"Easier comment toggle (vim interprets <C-/> as <C-_>)
map <C-_> <plug>NERDCommenterToggle
"When popup is visible use tab to cycle through suggestions
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<TAB>"
"Press return again to disable highlighting after searching
nnoremap <silent><CR> :noh<CR><CR>
"Taglist
nnoremap <C-t> :TlistOpen<CR>
"ctrlsf
nmap  <C-x> <Plug>CtrlSFPrompt
"coc
nnoremap <silent> <leader>d <Plug>(coc-definition)
nnoremap <silent> <leader>y <Plug>(coc-type-definition)
nnoremap <silent> <leader>i <Plug>(coc-implementation)
nnoremap <silent> <leader>r <Plug>(coc-references)
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
nn <silent> <C-k> :call CocActionAsync('doHover')<cr>
" Navigate diagnostics
nnoremap <silent> [g <Plug>(coc-diagnostic-prev)
nnoremap <silent> ]g <Plug>(coc-diagnostic-next)
"Rename current word
nnoremap <leader>rn <Plug>(coc-rename)
nnoremap q <Plug>(coc-codeaction)
nnoremap <leader>f  <Plug>(coc-fix-current)

"incsearch.vim remaps so nohl is set after actions
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
"vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
