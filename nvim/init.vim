" -----------------------------------------------------------------------------
" GENERAL SETTINGS
" -----------------------------------------------------------------------------

" Editor layout
set breakindent    " indent lines when they're softwrapped
set breakindentopt=shift:2,min:20 " settings for breakindent
set linebreak      " don't break within words
set noshowmode     " disable showing mode because lightline does that
set number         " show line numbers
set ruler          " show ruler
set wrap           " softwrap when the text runs longer than the window

" Search
set hlsearch       " highlight search results
set ignorecase     " ignore case when searching for lowercase terms
set incsearch      " make search results more browser-y
set smartcase      " don't ignore case when searching for uppercase terms

" Indenting and tabs
set autoindent     " copy indent from current line when starting a new line
set expandtab      " insert spaces instead of tabs
set shiftwidth=2   " set width of a tabstop when shifting lines
set smartindent    " smart autoindenting for programming (e.g. after {)
set smarttab       " insert `shiftwidth` tabs at the beginning of a line
set tabstop=2      " set width of a tabstop

" Behavior
set autoread       " refresh files when they change
set mouse=a        " let me click on stuff if i want to
set switchbuf=usetab,newtab " open buffers in new tabs or focus exisiting tab
set wildmenu       " enable better completion

" Disable backups because it's stored in git anyway
set nobackup
set noswapfile

" COC
set shortmess+=c   " Don't pass messages to ins-completion-menu
set signcolumn=yes " Show extra column for diagnostics

" -----------------------------------------------------------------------------
" PLUG
" -----------------------------------------------------------------------------

if empty(glob(stdpath('data') . '/site/autoload/plug.vim'))
  silent !curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" -----------------------------------------------------------------------------
" PLUGINS
" -----------------------------------------------------------------------------

call plug#begin(stdpath('data') . '/plugged')
  " General
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'maxbrunsfeld/vim-yankstack'
  Plug 'terryma/vim-expand-region'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'terryma/vim-smooth-scroll'
  
  " Languages
  Plug 'alexlafroscia/postcss-syntax.vim'
  Plug 'leafgarland/typescript-vim'
  Plug 'pangloss/vim-javascript'
  Plug 'plasticboy/vim-markdown'
  Plug 'posva/vim-vue'
  Plug 'mattn/emmet-vim'

  " COC
  " Install ":CocInstall coc-marketplace" for managing langugage servers  
  Plug 'neoclide/coc.nvim', { 'branch': 'release' }

  " Color schemes
  Plug 'ayu-theme/ayu-vim'
  Plug 'kaicataldo/material.vim'
call plug#end()

" Color scheme
if (has("termguicolors"))
  set termguicolors
endif

set background=dark
let g:ayucolor = 'mirage'
let g:material_theme_style = 'palenight'
let g:lightline = { 'colorscheme': 'material_vim' }
colorscheme material

" CTRLP
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrl_p_show_hidden = 1
let g:ctrlp_working_path_mode = 'ra'

" Languages
let g:vue_pre_processors = 'detect_on_enter'

" -----------------------------------------------------------------------------
" KEY MAPPINGS
" -----------------------------------------------------------------------------

let mapleader = '-'

" Quick access to settings
nmap <leader>; :tabnew ~/.config/nvim/init.vim<cr>

" Yankstack access
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

" Window navigation
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l

" Smooth scrolling
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 10, 2)<cr>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 10, 2)<cr>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 10, 4)<cr>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 10, 4)<cr>

" COC
inoremap <silent><expr> <c-space> coc#refresh()
nmap gd <Plug>(coc-definition)
nmap gy <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)
nmap <leader>di <Plug>(coc-diagnostic-next)
nmap <leader>DI :CocDiagnostics<cr>
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>fi <Plug>(coc-fix-current)
nmap <leader>FI :CocAction('format')<cr>

" -----------------------------------------------------------------------------
" COMMANDS
" -----------------------------------------------------------------------------

" COC
command! -nargs=0 OrganizeImports :call CocAction('runCommand', 'editor.action.organizeImport')
command! -nargs=0 Prettier :CocCommand prettier.formatFile
