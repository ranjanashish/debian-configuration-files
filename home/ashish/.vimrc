""""" Path to this configuration file is ~/.vimrc """""

" GLOBAL SETTING
""""""""""""""""
" general
set nocompatible      " MUST BE FIRST LINE!!! Vi IMproved
set autoindent        " 
set cursorline        " highlight current line
set encoding=utf-8    " use UTF-8
set lazyredraw        " 
set nobackup          " 
set noswapfile        " 
set pastetoggle=<F10> " 
set scrolloff=3       " minimal number of screen lines to keep above and below the cursor
set showcmd           " display incomplete commands
set visualbell        " error bells are displayed visually
set wildmenu          " show autocomplete menus
set wildignore=*.o,*~ " 
set tags=./tags;$HOME " look in the current directory for 'tags', and work up the tree towards $HOME until one is found
" search
set ignorecase " ignore case when searching
set incsearch  " search as you type
" tab
set tabstop=4 " a tab equals these many columns
set expandtab " insert appropriate number of spaces instead of a tab
set shiftwidth=4
set smarttab
" required by plugins
set grepprg=grep\ -nH\ $* " REQUIRED!!! by vim-latexsuite
set laststatus=2          " REQUIRED!!! by powerline (always have status line)
set t_Co=256              " REQUIRED!!! by powerline

" SYNTAX
""""""""
syntax on " enable syntax highlighting.

" AUTOCOMMAND
"""""""""""""
" autocmd {event} {pattern} {cmd}
"""""""""""""""""""""""""""""""""
" automatically set the format program 'astyle' for formatting C/C++/C#/Java code
autocmd BufNewFile,BufRead *.h,*.c,*.hpp,*.cpp,*.cs set formatprg=astyle\ --style=allman\ --unpad-paren\ --pad-oper\ --pad-header
autocmd BufNewFile,BufRead *.java set formatprg=astyle\ --style=java\ --unpad-paren\ --pad-oper\ --pad-header
" automatically set the format program 'tidy' for formatting HTML code
autocmd BufNewFile,BufRead *.htm,*.html set formatprg=tidy
" automatically do the syntax highlighting for arudino commands
autocmd BufNewFile,BufRead *.ino setlocal filetype=arduino

" GVIM
""""""
if has('gui_running')
    set guifont=Monaco\ Regular\ 11 " font and font-size
    set guioptions=aivc
endif

" CROSS-PLATFORM
""""""""""""""""
if has('win32') || has('win64')
    set rtp=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

" POWERLINE
"""""""""""
set rtp+=~/.local/lib/python2.7/site-packages/powerline/bindings/vim

" VUNDLE
""""""""
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'https://github.com/gmarik/vundle'
" look and feel
Bundle 'https://github.com/tomasr/molokai'
" programming
Bundle 'https://github.com/Shougo/neocomplcache'
Bundle 'https://github.com/Shougo/neosnippet'
Bundle 'https://github.com/Rip-Rip/clang_complete'
Bundle 'https://github.com/scrooloose/syntastic'
Bundle 'https://github.com/scrooloose/nerdcommenter'
Bundle 'https://github.com/majutsushi/tagbar'
Bundle 'https://github.com/tpope/vim-fugitive'
Bundle 'https://github.com/gregsexton/gitv'
Bundle 'https://github.com/vim-scripts/DoxygenToolkit.vim'
Bundle 'https://github.com/davidhalter/jedi-vim'
Bundle 'https://github.com/derekwyatt/vim-scala'
Bundle 'https://github.com/rstacruz/sparkup', {'rtp': 'vim/'}
" syntax
Bundle 'https://github.com/vim-scripts/Arduino-syntax-file'
" utility
Bundle 'https://github.com/Raimondi/delimitMate'
Bundle 'https://github.com/vim-scripts/Align'
Bundle 'https://github.com/Lokaltog/vim-easymotion'
Bundle 'https://github.com/scrooloose/nerdtree'
Bundle 'https://github.com/kien/ctrlp.vim'
Bundle 'https://github.com/sjl/gundo.vim'
Bundle 'https://github.com/tpope/vim-surround'
Bundle 'https://github.com/trotter/autojump.vim'
filetype plugin indent on 

" COLORSCHEME
"""""""""""""
colorscheme molokai

" ALL VARIABLE
""""""""""""""
let mapleader=","

" GLOBAL VARIABLE
"""""""""""""""""
" clang_complete
let g:clang_use_library      = 1 " instead of calling the 'clang/clang++' tool use 'libclang' directly
let g:clang_auto_select      = 0 " select nothing from the popup menu
let g:clang_complete_auto    = 0
let g:clang_complete_copen   = 1 " open quickfix window on error
" neocomplcache
let g:neocomplcache_enable_at_startup            = 1
let g:neocomplcache_enable_smart_case            = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion   = 1
let g:neocomplcache_min_syntax_length            = 2
" vim-latexsuite
let g:tex_flavor              = 'latex'
let g:Tex_DefaultTargetFormat = 'pdf'
" DoxygenToolkit
let g:DoxygenToolkit_authorName = "Ashish Ranjan (Jalan)"
" snipmate
let g:snips_author              = "Ashish Ranjan (Jalan)"

" MAP
"""""
" insert mode
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" normal mode
nmap <silent> <leader>ev : e $HOME/.vimrc<CR>
nmap <silent> <leader>sv : so $HOME/.vimrc<CR>
nnoremap <leader>g       : GundoToggle<CR>
nnoremap <leader>n       : NERDTreeToggle<CR>
nnoremap <leader>t       : TagbarToggle<CR>
 
