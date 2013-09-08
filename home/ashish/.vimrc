""""" Path to this configuration file is $HOME/.vimrc """""

" REQUIREMENTS
""""""""""""""
" 1. git        ** unix  (apt-get) ** win32 (http://code.google.com/p/msysgit/)             ** win64 (http://code.google.com/p/msysgit/)
" 2. curl       ** unix  (apt-get) ** win32 (http://code.google.com/p/msysgit/)             ** win64 (http://code.google.com/p/msysgit/)
" 3. astyle     ** unix  (apt-get) ** win32 ()                                              ** win64 ()
" 4. tidy       ** unix  (apt-get) ** win32 ()                                              ** win64 ()
" 5. gcc        ** unix  (apt-get) ** win32 (https://sourceforge.net/projects/mingwbuilds/) ** win64 (https://sourceforge.net/projects/mingwbuilds/)
" 6. g++        ** unix  (apt-get) ** win32 (https://sourceforge.net/projects/mingwbuilds/) ** win64 (https://sourceforge.net/projects/mingwbuilds/)
" 7. python     ** unix  (apt-get) ** win32 ()                                              ** win64 ()
" 8. ruby       ** unix  (apt-get) ** win32 ()                                              ** win64 ()
" 9. scala      ** unix  (apt-get) ** win32 ()                                              ** win64 ()
" 10. ctags     ** unix  (apt-get) ** win32 ()                                              ** win64 ()
" 11. clang     ** unix  (apt-get) ** win32 ()                                              ** win64 ()
" 12. autojump  ** unix  (apt-get) ** win32 ()                                              ** win64 ()
" 13. powerline ** unix  (git)     ** win32 ()                                              ** win64 ()
" 14. vundle    ** unix  (git)     ** win32 (git)                                           ** win64 (git)

" GLOBAL SETTING
""""""""""""""""
" general
set nocompatible                    " MUST BE FIRST LINE!!! Vi IMproved
set autoindent                      " take indent for new line from previous line
if has('unix')
    set clipboard=unnamedplus       " 
elseif has('win32') || has('win64')
    set clipboard=unnamed           " 
endif
set cursorline                      " highlight current line
set encoding=utf-8                  " use UTF-8
set lazyredraw                      " don't redraw while executing macros
set nobackup                        " 
set noswapfile                      " 
set number                          " print the line number in front of each line
set pastetoggle=<F10>               " 
set scrolloff=3                     " minimum number of lines above and below cursor
set showcmd                         " display incomplete commands
set visualbell                      " error bells are displayed visually
set wildmenu                        " show autocomplete menus
set wildignore=*.o,*~               " files matching these patterns are not completed
set tags=./tags;$HOME               " look in the current directory for 'tags', and work up the tree towards $HOME until one is found
" search
set ignorecase                      " ignore case when searching
set incsearch                       " search as you type
" tab
set tabstop=4                       " number of spaces that <tab> in file uses
set expandtab                       " insert appropriate number of spaces instead of a tab
set shiftwidth=4                    " number of spaces to use for (auto)indent step
set smarttab                        " use 'shiftwidth' when inserting <tab>
" required by plugins
set grepprg=grep\ -nH\ $*           " REQUIRED!!! by vim-latexsuite
set laststatus=2                    " REQUIRED!!! by powerline (always have status line)
set t_Co=256                        " REQUIRED!!! by powerline

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
autocmd BufNewFile,BufRead *.json set formatprg=python\ -mjson.tool

" automatically do the syntax highlighting for arudino commands
autocmd BufNewFile,BufRead *.ino setlocal filetype=arduino

" F9 compile
autocmd FileType c map <F9> :!gcc -o "%:p:r.out" "%:p" && "%:p:r.out"<CR>
autocmd FileType cpp map <F9> :!g++ -std=c++11 -pthread -o "%:p:r.out" "%:p" && "%:p:r.out"<CR>
autocmd FileType java map <F9> :!javac "%:p" && java -cp "%:p:h" "%:t:r"<CR>
autocmd FileType javascript map <F9> :!nodejs "%:p"<CR>
autocmd FileType lua map <F9> :!lua "%:p"<CR>
autocmd FileType python map <F9> :!python "%:p"<CR>
autocmd FileType ruby map <F9> :!ruby "%:p"<CR>
autocmd FileType scala map <F9> :!scala "%:p"<CR>

autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" GVIM
""""""
if has('gui_running')
    set guifont=Monospace\ 12 " font and font-size
endif

" CROSS-PLATFORM
""""""""""""""""
if has('win32') || has('win64')
    set rtp=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

" VUNDLE
""""""""
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'https://github.com/gmarik/vundle'
" look and feel
Bundle 'https://github.com/tomasr/molokai'
Bundle 'https://github.com/bling/vim-airline'
" programming
"Bundle 'https://github.com/Shougo/neocomplcache'
"Bundle 'https://github.com/Shougo/neosnippet'
"Bundle 'https://github.com/honza/vim-snippets'
Bundle 'https://github.com/scrooloose/syntastic'
Bundle 'https://github.com/scrooloose/nerdcommenter'
Bundle 'https://github.com/majutsushi/tagbar'
Bundle 'https://github.com/tpope/vim-fugitive'
Bundle 'https://github.com/gregsexton/gitv'
Bundle 'https://github.com/vim-scripts/DoxygenToolkit.vim'
Bundle 'https://github.com/derekwyatt/vim-scala'
Bundle 'https://github.com/elzr/vim-json'
Bundle 'https://github.com/rstacruz/sparkup', {'rtp': 'vim/'}
" syntax
Bundle 'https://github.com/vim-scripts/Arduino-syntax-file'
" utility
Bundle 'https://github.com/Raimondi/delimitMate'
Bundle 'https://github.com/vim-scripts/Align'
Bundle 'https://github.com/Lokaltog/vim-easymotion'
Bundle 'https://github.com/scrooloose/nerdtree'
Bundle 'https://github.com/kien/ctrlp.vim'
Bundle 'https://github.com/tpope/vim-surround'
Bundle 'https://github.com/tpope/vim-unimpaired'
" unix only bundles
if has('unix')
    Bundle 'https://github.com/trotter/autojump.vim'
endif
" python support required
if has('python')
    Bundle 'https://github.com/Rip-Rip/clang_complete'
    Bundle 'https://github.com/sjl/gundo.vim'
endif
filetype plugin indent on 

" COLORSCHEME
"""""""""""""
colorscheme molokai

" ALL VARIABLE
""""""""""""""
let mapleader = ","

" GLOBAL VARIABLE
"""""""""""""""""
" clang_complete
let g:clang_use_library        = 1                       " instead of calling the 'clang/clang++' tool use 'libclang' directly
if has('unix')
    let g:clang_library_path   = '/usr/lib/llvm-3.4/lib' " contains libclang.so
endif
let g:clang_auto_select        = 1                       " select nothing from the popup menu
"let g:clang_complete_auto      = 0                       " 
let g:clang_complete_copen     = 1                       " open quickfix window on error
" neocomplcache
"let g:neocomplcache_enable_at_startup            = 1
"let g:neocomplcache_enable_smart_case            = 1
"let g:neocomplcache_enable_camel_case_completion = 1
"let g:neocomplcache_enable_underbar_completion   = 1
"let g:neocomplcache_min_syntax_length            = 2
" neosnippet
"let g:neosnippet#snippets_directory = '~/.vim/bundle/vim-snippets/snippets'
" syntastic
let g:syntastic_cpp_compiler_options = ' -std=c++11'
" vim-latexsuite
let g:tex_flavor              = 'latex'
let g:Tex_DefaultTargetFormat = 'pdf'
" DoxygenToolkit
let g:DoxygenToolkit_authorName = "Ashish Ranjan (Jalan)"

" MAP
"""""
" leader
nmap <silent> <leader>ev :e $HOME/.vimrc<CR>
nmap <silent> <leader>sv :so $HOME/.vimrc<CR>
nnoremap <leader>g       :GundoToggle<CR>
nnoremap <leader>n       :NERDTreeToggle<CR>
nnoremap <leader>t       :TagbarToggle<CR>
" non-leader
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

