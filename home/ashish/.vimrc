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
" 13. vundle    ** unix  (git)     ** win32 (git)                                           ** win64 (git)

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
set nowrap
set number                          " print the line number in front of each line
set pastetoggle=<F10>               " 
set scrolloff=3                     " minimum number of lines above and below cursor
set showcmd                         " display incomplete commands
"set synmaxcol=200
set visualbell                      " error bells are displayed visually
set wildmenu                        " show autocomplete menus
set wildignore=*.o,*~               " files matching these patterns are not completed
set tags=./tags;$HOME               " look in the current directory for 'tags', and work up the tree towards $HOME until one is found
" search
set hlsearch                        " highlight search
set ignorecase                      " ignore case when searching
set incsearch                       " search as you type
" tab
set tabstop=4                       " number of spaces that <tab> in file uses
set expandtab                       " insert appropriate number of spaces instead of a tab
set shiftwidth=4                    " number of spaces to use for (auto)indent step
set smarttab                        " use 'shiftwidth' when inserting <tab>
" required by plugins
set grepprg=grep\ -nH\ $*           " REQUIRED!!! by vim-latexsuite

" SYNTAX
""""""""
syntax on " enable syntax highlighting.

" AUTOCOMMAND
"""""""""""""
" autocmd {event} {pattern} {cmd}
"""""""""""""""""""""""""""""""""
" format programs
autocmd BufNewFile,BufRead *.h,*.c,*.hpp,*.cpp,*.cs set formatprg=astyle\ --style=allman\ --unpad-paren\ --pad-oper\ --pad-header
autocmd BufNewFile,BufRead *.java                   set formatprg=astyle\ --style=java\   --unpad-paren\ --pad-oper\ --pad-header
autocmd BufNewFile,BufRead *.htm,*.html             set formatprg=tidy
autocmd BufNewFile,BufRead *.xml                    set formatprg=xmllint\ --encode\ UTF-8\ --format\ %
autocmd BufNewFile,BufRead *.json                   set formatprg=python\ -mjson.tool

" F9 compile
autocmd FileType c          map <F9> :!gcc -o "%:p:r.out" "%:p" && "%:p:r.out"<CR>
autocmd FileType cpp        map <F9> :!g++ -std=c++11 -pthread -o "%:p:r.out" "%:p" && "%:p:r.out"<CR>
autocmd FileType erlang     map <F9> :!erlc -o "%:p:h" "%:p" && erl -noshell -pa "%:p:h" -s "%:t:r" -eval 'init:stop()'<CR>
autocmd FileType java       map <F9> :!javac "%:p" && java -cp "%:p:h" "%:t:r"<CR>
autocmd FileType javascript map <F9> :!nodejs "%:p"<CR>
autocmd FileType lua        map <F9> :!lua "%:p"<CR>
autocmd FileType python     map <F9> :!python "%:p"<CR>
autocmd FileType ruby       map <F9> :!ruby "%:p"<CR>
autocmd FileType scala      map <F9> :!scala "%:p"<CR>

" syntax highlighting for arduino files
autocmd BufNewFile,BufRead *.ino setlocal filetype=arduino

" close pop-up menu (pum)
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave  * if pumvisible() == 0|pclose|endif

" 
autocmd VimEnter * TagbarToggle

" GVIM
""""""
if has('gui_running')
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 12 " font and font-size
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
endif

" CROSS-PLATFORM
""""""""""""""""
if has('win32') || has('win64')
    set rtp=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

" VUNDLE
""""""""
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'https://github.com/gmarik/Vundle.vim'
" look and feel
Plugin 'https://github.com/tomasr/molokai'
Plugin 'https://github.com/bling/vim-airline'
" programming
Plugin 'https://github.com/Shougo/neocomplcache'
if has('python')
    Plugin 'https://github.com/Rip-Rip/clang_complete'
    Plugin 'https://github.com/SirVer/ultisnips'
endif
Plugin 'https://github.com/honza/vim-snippets'
Plugin 'https://github.com/scrooloose/syntastic'
Plugin 'https://github.com/scrooloose/nerdcommenter'
Plugin 'https://github.com/majutsushi/tagbar'
Plugin 'https://github.com/tpope/vim-fugitive'
Plugin 'https://github.com/gregsexton/gitv'
Plugin 'https://github.com/airblade/vim-gitgutter'
Plugin 'https://github.com/vim-scripts/DoxygenToolkit.vim'
Plugin 'https://github.com/derekwyatt/vim-scala'
Plugin 'https://github.com/davidhalter/jedi-vim'
Plugin 'https://github.com/rstacruz/sparkup', {'rtp': 'vim/'}
" syntax
Plugin 'https://github.com/vim-scripts/Arduino-syntax-file'
" utility
Plugin 'https://github.com/Raimondi/delimitMate'
Plugin 'https://github.com/vim-scripts/Align'
Plugin 'https://github.com/Lokaltog/vim-easymotion'
Plugin 'https://github.com/scrooloose/nerdtree'
Plugin 'https://github.com/kien/ctrlp.vim'
Plugin 'https://github.com/tpope/vim-surround'
Plugin 'https://github.com/tpope/vim-unimpaired'
Plugin 'https://github.com/tpope/vim-vinegar'
if has('python')
    Plugin 'https://github.com/sjl/gundo.vim'
endif
if has('unix')
    Plugin 'https://github.com/trotter/autojump.vim'
endif
call vundle#end()
filetype plugin indent on 

" COLORSCHEME
"""""""""""""
colorscheme molokai

" ALL VARIABLE
""""""""""""""
let mapleader = "\<Space>"

" GLOBAL VARIABLE
"""""""""""""""""
" airline
let g:airline_powerline_fonts  = 1
" clang_complete
let g:clang_use_library        = 1                       " instead of calling the 'clang/clang++' tool use 'libclang' directly
if has('unix')
    let g:clang_library_path   = '/usr/lib/llvm-3.4/lib' " contains libclang.so
endif
let g:clang_auto_select        = 1                       " select nothing from the popup menu
"let g:clang_complete_auto      = 0                       " 
let g:clang_complete_copen     = 1                       " open quickfix window on error
" neocomplcache
let g:neocomplcache_enable_at_startup            = 1
let g:neocomplcache_enable_smart_case            = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion   = 1
let g:neocomplcache_min_syntax_length            = 2
" syntastic
let g:syntastic_cpp_compiler_options = ' -std=c++11'
" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" vim-latexsuite
let g:tex_flavor              = 'latex'
let g:Tex_DefaultTargetFormat = 'pdf'
" DoxygenToolkit
let g:DoxygenToolkit_authorName = "Ashish Ranjan (Jalan)"

" MAP
"""""
if has('gui_running')
    map <C-f> :promptrepl<CR>
endif
map <C-t> :tabnew<CR>

nmap <silent> <leader>ev :e $HOME/.vimrc<CR>
nmap <silent> <leader>sv :so $HOME/.vimrc<CR>
nnoremap <leader>g       :GundoToggle<CR>
nnoremap <leader>n       :NERDTreeToggle<CR>
nnoremap <leader>t       :TagbarToggle<CR>
noremap <silent><Leader>/ :nohls<CR>

nmap gh        <Plug>GitGutterNextHunk
nmap gH        <Plug>GitGutterPrevHunk
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" resize splits
nnoremap <M-j> <C-w>-
nnoremap <M-k> <C-w>+
nnoremap <M-h> <C-w><
nnoremap <M-l> <C-w>>

nnoremap Y y$
nnoremap j gj
nnoremap k gk

