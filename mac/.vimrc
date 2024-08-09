set tabstop=4
set shiftwidth=4
set smarttab
set ai
set showmatch
set ignorecase
set number
set encoding=utf-8
set backspace=indent,eol,start
set ttyfast
set cursorline
set showcmd
set smartcase
set incsearch
set gdefault
set wrap
" set timeoutlen=250
set laststatus=2
set autochdir
set expandtab

" autoload .vimrc
autocmd! bufwritepost .vimrc source %
" autocmd GUIEnter * <C-T-Up>
set pastetoggle=<F4>
set clipboard=unnamedplus
set mouse=a

set nobackup
set nowritebackup
set noswapfile

map <F2> :mksession! ~/vim_session <cr>
map <F3> :source ~/vim_session <cr>
map <C-n> :NERDTreeToggle<cr>

let mapleader = ","
inoremap jj <Esc>
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <leader>n :tabprevious<cr>
nnoremap <leader>m :tabnext<cr>
nnoremap <leader>h :tabm -1<cr>
nnoremap <leader>j :tabm +1<cr>
nnoremap <leader>ev <C-w><C-v><C-l>:e ~/.vimrc<cr>
nnoremap <leader><space> :noh<cr>
nnoremap ; :
nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
vnoremap <leader>s :sort<cr>
vnoremap < <gv
vnoremap > >gv

if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

" colorscheme CandyPaper
if (has("termguicolors"))
     set termguicolors
endif


autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
autocmd  FileType  php setlocal omnifunc=phpcomplete_extended#CompletePHP

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

"Plugin 'rust-lang/rust.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
"Plugin 'honza/vim-snippets'
"Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
"Plugin 'guns/vim-clojure-static'
Plugin 'luochen1990/rainbow'
let g:rainbow_active = 1
Plugin 'othree/eregex.vim'
Plugin 'bling/vim-airline'
"let g:airline_powerline_fonts = 1
Plugin 'tpope/vim-fugitive'
Plugin 'fatih/vim-go'
let g:go_fmt_experimental = 1
Plugin 'terryma/vim-multiple-cursors'

Plugin 'mechatroner/rainbow_csv'

let g:user_emmet_leader_key="<C-l>" " don't forget to press , :)
let g:user_emmet_settings = {
\    'indentation' : '    '
\}

let g:UltiSnipsExpandTrigger="<C-x>"
"let g:UltiSnipsJumpForwardTrigger="<C-x>"
let g:UltiSnipsJumpBackwardTrigger="<C-b>"

Plugin 'jacoborus/tender.vim'

call vundle#end()


filetype plugin indent on
syntax on
" syntax enable
colorscheme tender

" set airline theme
let g:airline_theme = 'tender'

set guifont=Source\ Code\ Pro\ 10
set noshowmode " we have airline, dude
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

let g:airline_powerline_fonts = 1
let NERDTreeMapOpenInTab='<C-Enter>'
let g:phpcomplete_parse_docblock_comments = 1

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.xml,*.wsdl,*.xsd'
let g:closetag_xhtml_filenames = '*.xhtml,*.xml,*.xsd,*.wsdl'

