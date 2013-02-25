""""" ranjanashish : Path to this configuration file is ~/.vimrc """""

" SET
"""""
" general
set nocompatible   " MUST BE FIRST LINE!!! Vi IMproved
set autoindent
set encoding=utf-8 " use UTF-8
set scrolloff=999  " minimal number of screen lines to keep above and below the cursor
set showcmd        " display incomplete commands
set visualbell     " error bells are displayed visually
set wildmenu       " show autocomplete menus
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
" automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')
" automatically do the syntax highlighting for arudino commands
autocmd! BufNewFile,BufRead *.pde setlocal ft=arduino

" GVIM
""""""
if has('gui_running')
    set guifont=Monospace\ 10 " font and font-size
    set lines=999 columns=999 " maximize initial gvim window
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
Bundle 'https://github.com/tpope/vim-fugitive'
Bundle 'https://github.com/rstacruz/sparkup', {'rtp': 'vim/'}
" syntax
Bundle 'https://github.com/vim-scripts/Arduino-syntax-file'
" utility
Bundle 'https://github.com/Raimondi/delimitMate'
Bundle 'https://github.com/vim-scripts/Align'
Bundle 'https://github.com/Lokaltog/vim-easymotion'
Bundle 'https://github.com/wincent/Command-T'
Bundle 'https://github.com/fholgado/minibufexpl.vim'
filetype plugin indent on 

" COLORSCHEME
"""""""""""""
colorscheme molokai

let g:tex_flavor='latex'

