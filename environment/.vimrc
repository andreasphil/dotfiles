" -----------------------------------------------------------------------------
" VIM SETTINGS
"
" Much of this is based on https://github.com/amix/vimrc
" -----------------------------------------------------------------------------

" Editor layout
set breakindent    " indent lines when they're softwrapped
set breakindentopt=shift:2,min:20 " settings for breakindent
set laststatus=2   " always show the status line 
set linebreak      " don't break within words
set noshowmode     " disable showing mode because lightline does that
set number         " show line numbers
set ruler          " show ruler
set signcolumn=yes " always show status column next to line numbers
set wrap           " softwrap when the text runs longer than the window
set colorcolumn=80 " show guide for limiting line length

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
set wildmenu       " enable better completion
set updatetime=400 " snappier updates

" Disable backups because it's stored in git anyway
set nobackup
set nowritebackup
set noswapfile

" -----------------------------------------------------------------------------
" PLUG
" -----------------------------------------------------------------------------

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" -----------------------------------------------------------------------------
" PLUGINS
" -----------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')
  " General
  Plug 'airblade/vim-gitgutter'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'maxbrunsfeld/vim-yankstack'
  Plug 'mileszs/ack.vim'
  Plug 'preservim/nerdtree'
  Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
  Plug 'terryma/vim-expand-region'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'tpope/vim-commentary'
  
  " Languages
  Plug 'alexlafroscia/postcss-syntax.vim'
  Plug 'leafgarland/typescript-vim'
  Plug 'pangloss/vim-javascript'
  Plug 'plasticboy/vim-markdown'
  Plug 'posva/vim-vue'
  Plug 'mattn/emmet-vim'

  " Color schemes
  Plug 'kaicataldo/material.vim'
  Plug 'cocopon/iceberg.vim'
call plug#end()

" Theme
set background=dark
let g:material_theme_style = 'palenight'
let g:lightline = { 'colorscheme': 'iceberg' }
colorscheme iceberg

" CTRLP
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrl_p_show_hidden = 1
let g:ctrlp_working_path_mode = 'ra'

" Languages
let g:vue_pre_processors = 'detect_on_enter'
let g:javascript_plugin_jsdoc = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1

" Other
let g:ackprg = 'ag --vimgrep'
let NERDTreeShowHidden = 1

" -----------------------------------------------------------------------------
" KEY MAPPINGS
" -----------------------------------------------------------------------------

let mapleader = '-'

" Quick access to settings
nmap <leader>; :tabnew ~/.vimrc<cr>

" Yankstack access
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

" Window navigation
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l

" NERDTree
nmap <leader>e :NERDTreeToggle<cr>
nmap <leader>E :NERDTreeFocus<cr>
