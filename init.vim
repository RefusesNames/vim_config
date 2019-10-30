
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/AppData/Local/nvim/bundle/Vundle.vim
call vundle#begin('~/AppData/Local/nvim/bundle')
Plugin 'VundleVim/Vundle.vim'

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'luochen1990/rainbow'
Plugin 'nightsense/vrunchbang'
Plugin 'scrooloose/nerdcommenter'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'rhysd/git-messenger.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
Plugin 'jayli/vim-easydebugger'
Plugin 'beanworks/vim-phpfmt'

call vundle#end()

""""""""""""""""""""""
""""""" PYTHON """""""
""""""""""""""""""""""
"let g:python3_host_prog='~/AppData\Local\Programs\Python\Python37\python'
"let g:python_host_prog='~/AppData\Local\Programs\Python\Python27\python'

"let g:ycm_path_to_python_interpreter='~/AppData\Local\Programs\Python\Python37\python'
let g:phpfmt_standard = 'PSR2'
let g:phpfmt_autosave = 0
""""""""""""""""""""""""""
""""""" APPEARANCE """""""
""""""""""""""""""""""""""
colorscheme vrunchbang-dark

set encoding=utf-8 " necessary for powerline symbols to show under windows


""""""""""""""""""""""
""""""" CTRL-P """""""
""""""""""""""""""""""
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_extensions = ['line']
let g:ctrlp_custom_ignore = { 'dir' : '.*[\/]thirdparty\|node_modules\|bin\|\.git\|\.vscode|vendor'}


"""""""""""""""""""""""
""""""" AIRLINE """""""
"""""""""""""""""""""""
set laststatus=2 " always show the status bar
let g:airline_powerline_fonts=1


""""""""""""""""""""""""""""""""""""""""""""
""""""" RAINBOW PARENTHESES IMPROVED """""""
""""""""""""""""""""""""""""""""""""""""""""
let g:rainbow_active = 1


"""""""""""""""""""""""""""
""""""" KEYBINDINGS """""""
"""""""""""""""""""""""""""
" More intuitive navigation when lines are wrapped
nnoremap k gk
nnoremap j gj
nnoremap 0 g0
nnoremap $ g$

" Easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


"""""""""""""""""""""""""""
""""""" INDENTATION """""""
"""""""""""""""""""""""""""
set tabstop=4       " Number of spaces that a <Tab> in the file counts for.
set shiftwidth=4    " Number of spaces to use for each step of (auto)indent.
set expandtab
"set noexpandtab     " Use actual <Tab> instead of spaces for indentation
set smarttab        " When on, a <Tab> in front of a line inserts blanks
                    " according to 'shiftwidth'. 'tabstop' is used in other
                    " places. A <BS> will delete a 'shiftwidth' worth of space
                    " at the start of the line.
set autoindent      " Copy indent from current line when starting a new line
                    " (typing <CR> in Insert mode or when using the "o" or "O"
                    " command).
set breakindent     " when wrapping a line, consider indentation


""""""""""""""""""""""""""""
""""""" LINE NUMBERS """""""
""""""""""""""""""""""""""""
set number          " Show absolute line numbers.
set relativenumber	" Show relative line numbers.


""""""""""""""""""""""
""""""" SEARCH """""""
""""""""""""""""""""""
set incsearch       " While typing a search command, show immediately where the
set ignorecase
set smartcase       " Override the 'ignorecase' option if the search pattern


let g:ycm_use_clangd = 0


set formatoptions=c,q,r,t " This is a sequence of letters which describes how
                    " automatic formatting is to be done.
                    "
                    " letter    meaning when present in 'formatoptions'
                    " ------    ---------------------------------------
                    " c         Auto-wrap comments using textwidth, inserting
                    "           the current comment leader automatically.
                    " q         Allow formatting of comments with "gq".
                    " r         Automatically insert the current comment leader
                    "           after hitting <Enter> in Insert mode.
                    " t         Auto-wrap text using textwidth (does not apply
                    "           to comments)
set wrap           " this enables 'visual' wrapping
set autoread       " automatically read file changes from outside
	" 'fixes' autoread, see: https://github.com/neovim/neovim/issues/1936
au FocusGained * :checktime
set shellslash
set noswapfile

language en_US

"set shell=wsl
set shell=powershell shellquote=( shellpipe=\| shellxquote=
set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
set shellredir=\|\ Out-File\ -Encoding\ UTF8
let g:terminal_color_0  = '#2e3436'
let g:terminal_color_1  = '#cc0000'
let g:terminal_color_2  = '#4e9a06'
let g:terminal_color_3  = '#c4a000'
let g:terminal_color_4  = '#3465a4'
let g:terminal_color_5  = '#75507b'
let g:terminal_color_6  = '#0b939b'
let g:terminal_color_7  = '#d3d7cf'
let g:terminal_color_8  = '#555753'
let g:terminal_color_9  = '#ef2929'
let g:terminal_color_10 = '#8ae234'
let g:terminal_color_11 = '#fce94f'
let g:terminal_color_12 = '#729fcf'
let g:terminal_color_13 = '#ad7fa8'
let g:terminal_color_14 = '#00f5e9'
let g:terminal_color_15 = '#eeeeec'

filetype plugin on
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
