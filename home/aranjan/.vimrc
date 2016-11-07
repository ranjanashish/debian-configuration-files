""""" Path to this configuration file is $HOME/.vimrc """""

" GLOBAL SETTING
""""""""""""""""
" general
set nocompatible                                        " MUST BE FIRST LINE!!! Vi IMproved
set autoindent                                          " take indent for new line from previous line
if has('unix')
    set clipboard=unnamedplus
elseif has('win64') || has('win32')
    set clipboard=unnamed
endif
set cursorline                                          " highlight current line
set encoding=utf-8                                      " use UTF-8
set lazyredraw                                          " don't redraw while executing macros
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:< " characters for displaying in list mode
set nobackup                                            " 
set noswapfile                                          " whether to use a swapfile for a buffer
set nowrap                                              " 
set number                                              " print the line number in front of each line
set pastetoggle=<F10>                                   " key code that causes 'paste' to toggle
set scrolloff=3                                         " minimum number of lines above and below cursor
set showcmd                                             " display incomplete commands
set synmaxcol=400                                       " maximum column to find syntax items
set visualbell                                          " error bells are displayed visually
set wildmenu                                            " show autocomplete menus
set wildignore=*.o,*~,*.pyc                             " files matching these patterns are not completed
set tags=./tags;$HOME                                   " look in the current directory for 'tags', and work up the tree towards $HOME until one is found
" search
set hlsearch                                            " highlight search
set ignorecase                                          " ignore case when searching
set incsearch                                           " search as you type
" tab
set tabstop=4                                           " number of spaces that <tab> in file uses
set expandtab                                           " insert appropriate number of spaces instead of a tab
set shiftwidth=4                                        " number of spaces to use for (auto)indent step
set smarttab                                            " use 'shiftwidth' when inserting <tab>
" required by plugins
set grepprg=grep\ -nH\ $*                               " REQUIRED!!! by vim-latexsuite
set laststatus=2                                        " REQUIRED!!! by vim-airline

" SYNTAX
""""""""
syntax on " enable syntax highlighting.

" AUTOCOMMAND
"""""""""""""
" autocmd {event} {pattern} {cmd}
"""""""""""""""""""""""""""""""""
" format programs
" NOTE: ``formatprg`` is a global option
autocmd BufEnter *.h,*.c,*.hpp,*.cpp,*.cs set formatprg=astyle\ --style=allman\ --unpad-paren\ --pad-oper\ --pad-header\ --align-pointer=type
autocmd BufEnter *.java                   set formatprg=astyle\ --style=java
autocmd BufEnter *.json                   set formatprg=python\ -mjson.tool
autocmd BufEnter *.py                     set formatprg=autopep8\ -
autocmd BufEnter *.htm,*.html             set formatprg=tidy
autocmd BufEnter *.xml                    set formatprg=xmllint\ --encode\ UTF-8\ --format\ %

" F9 compile
autocmd FileType c          map <F9> :!gcc -o "%:p:r.out" "%:p" && "%:p:r.out"<CR>
autocmd FileType cpp        map <F9> :!g++ -std=c++11 -pthread -o "%:p:r.out" "%:p" && "%:p:r.out"<CR>
autocmd FileType erlang     map <F9> :!erlc -o "%:p:h" "%:p" && erl -noshell -pa "%:p:h" -s "%:t:r" -eval 'init:stop()'<CR>
autocmd FileType java       map <F9> :!javac "%:p" && java -cp "%:p:h" "%:t:r"<CR>
autocmd FileType javascript map <F9> :!nodejs "%:p"<CR>
autocmd FileType lua        map <F9> :!lua "%:p"<CR>
autocmd FileType python     map <F9> :!python "%:p"<CR>
autocmd FileType ruby       map <F9> :!ruby "%:p"<CR>
autocmd FileType rust       map <F9> :!rustc -o "%:p:r.out" "%:p" && "%:p:r.out"<CR>
autocmd FileType scala      map <F9> :!scala "%:p"<CR>

" 
autocmd FileType c,cpp,java,python autocmd BufWritePre <buffer> :%s/\s\+$//e

" syntax highlighting for arduino files
autocmd BufNewFile,BufRead *.ino setlocal filetype=arduino

" close pop-up menu (pum)
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave  * if pumvisible() == 0|pclose|endif

" GVIM
""""""
if has('gui_running')
    set guioptions-=m  " no menubar
    set guioptions-=T  " no toolbar
    set guioptions-=r  " no right-hand scrollbar
    set guioptions-=L  " no left-hand scrollbar
    if has('gui_gtk3') || has('gui_gtk2')
        set guifont=Inconsolata\ for\ Powerline\ 14
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h14
    elseif has("gui_win32")
        set guifont=Consolas:h10:cANSI
    endif
endif

" CROSS-PLATFORM
""""""""""""""""
if has('win64') || has('win32')
    set rtp=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

" VIM-PLUG
""""""""""
call plug#begin('~/.vim/plugged')

" look and feel
Plug 'tomasr/molokai'
Plug 'vim-airline/vim-airline'
" programming
Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer'} " requires python
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'                     " requires python
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'
Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/indentLine'
Plug 'vim-scripts/DoxygenToolkit.vim', {'for': 'cpp'}
Plug 'rstacruz/sparkup',               {'for': 'html', 'rtp': 'vim/'}
Plug 'mitsuhiko/vim-jinja',            {'for': 'html'}
Plug 'python-rope/ropevim',            {'for': 'python'}                " requires python
Plug 'rust-lang/rust.vim',             {'for': 'rust'}
Plug 'derekwyatt/vim-scala',           {'for': 'scala'}
" syntax
Plug 'vim-scripts/Arduino-syntax-file'
" utility
Plug 'mhinz/vim-Startify'
Plug 'Raimondi/delimitMate'
Plug 'vim-scripts/Align'
Plug 'Lokaltog/vim-easymotion'
Plug 'scrooloose/nerdtree', {'on': ['NERDTree', 'NERDTreeToggle', 'NERDTreeFromBookmark']}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'terryma/vim-expand-region'
Plug 'rking/ag.vim'
Plug 'xolox/vim-misc' | Plug 'xolox/vim-session'
Plug 'sjl/gundo.vim'                                                    " requires python
Plug 'junegunn/limelight.vim', {'on': 'Limelight'}
Plug 'wellle/targets.vim'
if has('unix')
    Plug 'trotter/autojump.vim'
endif

call plug#end()

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
" airline - extensions
let g:airline#extensions#tagbar#enabled = 0

" nerdtree
let NERDTreeIgnore = ['^__pycache__$', '^bower_components$', '^node_modules$', '^tags$', '\.o$', '\.out$', '\.pyc$']

" session
let g:session_directory = '~/.vim/session'
let g:session_autoload = 'no'
let g:session_autosave = 'no'

" startify
let g:startify_list_order = [['   Sessions'], 'sessions', ['   Bookmarks'], 'bookmarks', ['   MRU'], 'files']

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

"let g:syntastic_error_symbol = '✗'
"let g:syntastic_style_error_symbol = '⁉️'
"let g:syntastic_warning_symbol = '⚠'
"let g:syntastic_style_warning_symbol = '≈≈'

let g:syntastic_cpp_compiler_options = ' -std=c++11'

let g:syntastic_python_python_exec = '/usr/bin/python3'
let g:syntastic_python_pylint_exe = 'pylint3'
let g:syntastic_python_checkers = ['python', 'flake8', 'mypy']

"highlight link SyntasticErrorSign SignColumn
"highlight link SyntasticWarningSign SignColumn
"highlight link SyntasticStyleErrorSign SignColumn
"highlight link SyntasticStyleWarningSign SignColumn

" ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" vim-latexsuite
let g:tex_flavor              = 'latex'
let g:Tex_DefaultTargetFormat = 'pdf'

" YouCompleteMe
let g:ycm_key_list_select_completion = ['<tab>, <Down>', '<Enter>']

" DoxygenToolkit
let g:DoxygenToolkit_authorName = "Ashish Ranjan (Jalan)"

" MAP
"""""
nnoremap Y y$
nnoremap j gj
nnoremap k gk

" resize splits
nnoremap <M-j> <C-w>-
nnoremap <M-k> <C-w>+
nnoremap <M-h> <C-w><
nnoremap <M-l> <C-w>>

if has('gui_running')
    map <C-f> :promptrepl<CR>
endif

nmap <silent> <leader>ev :e $HOME/.vimrc<CR>
nmap <silent> <leader>sv :so $HOME/.vimrc<CR>
nnoremap <leader>g       :GundoToggle<CR>
nnoremap <leader>n       :NERDTreeToggle<CR>
nnoremap <leader>t       :TagbarToggle<CR>
noremap <silent><Leader>/ :nohls<CR>

vmap v     <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
nmap gh    <Plug>GitGutterNextHunk
nmap gH    <Plug>GitGutterPrevHunk
