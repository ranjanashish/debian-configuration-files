""""" ranjanashish : Path to this configuration file is ~/.vimrc """""

python from powerline.bindings.vim import source_plugin; source_plugin()

" VUNDLE
""""""""
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'https://github.com/gmarik/vundle'
" look and feel
Bundle 'https://github.com/flazz/vim-colorschemes'
" programming
Bundle 'https://github.com/tpope/vim-fugitive'
Bundle 'https://github.com/rstacruz/sparkup', {'rtp': 'vim/'}
" syntax
Bundle 'https://github.com/vim-scripts/Arduino-syntax-file'
" utility
Bundle 'https://github.com/vim-scripts/Align'
Bundle 'https://github.com/Lokaltog/vim-easymotion'
Bundle 'https://github.com/wincent/Command-T'
filetype plugin indent on 

" AUTOCOMMAND
"""""""""""""
" automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')
" automatically do the syntax highlighting for arudino commands
autocmd! BufNewFile,BufRead *.pde setlocal ft=arduino

" COLORSCHEME
"""""""""""""
colorscheme molokai

" SET
"""""
" general
set autoindent
set encoding=utf-8 " use UTF-8
set nocompatible   " IMproved Vi
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

let g:tex_flavor='latex'

