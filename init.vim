
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=$MYVIMRC/../autoload/vim-plug.vim
call plug#begin('~/Neovim/bundle')

Plug 'luochen1990/rainbow'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'stanangeloff/php.vim'
Plug 'aserebryakov/vim-todo-lists'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'vimwiki/vimwiki'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'junegunn/fzf' " remember to 'scoop install fzf'
Plug 'junegunn/fzf.vim'
Plug 'cocopon/iceberg.vim'
Plug 'itchyny/lightline.vim'

call plug#end()

let g:VimTodoListsMoveItems = 0
let g:vimwiki_list = [{'path': '~/Desktop/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

let mapleader = "\<Space>"

command! JsonPrettify :%!python -m json.tool
nnoremap <leader>n :nohlsearch<CR>

""""""""""""""""""""""""""
""""""" GIT GUTTER """""""
""""""""""""""""""""""""""
let g:gitgutter_sign_added = ''
let g:gitgutter_sign_modified = 'ﰣ'
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_modified_removed = ''

"""""""""""""""""""
""""""" FZF """""""
"""""""""""""""""""
let g:fzf_nvim_statusline = 0 " disable statusline overwriting

nnoremap <silent> <leader><space> :GFiles<CR>
nnoremap <silent> <leader>F :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>A :Windows<CR>
nnoremap <silent> <leader>; :BLines<CR>
nnoremap <silent> <leader>o :BTags<CR>
nnoremap <silent> <leader>O :Tags<CR>
nnoremap <silent> <leader>? :History<CR>
"nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
nnoremap <silent> <leader>/ :Ag<CR>
nnoremap <silent> <leader>. :AgIn 

nnoremap <silent> K :call SearchWordWithAg()<CR>
vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
nnoremap <silent> <leader>gl :Commits<CR>
nnoremap <silent> <leader>ga :BCommits<CR>
nnoremap <silent> <leader>ft :Filetypes<CR>

imap <C-x><C-f> <plug>(fzf-complete-file-ag)
imap <C-x><C-l> <plug>(fzf-complete-line)

function! SearchWordWithAg()
    execute 'Ag' expand('<cword>')
endfunction

function! SearchVisualSelectionWithAg() range
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    let old_clipboard = &clipboard
    set clipboard&
    normal! ""gvy
    let selection = getreg('"')
    call setreg('"', old_reg, old_regtype)
    let &clipboard = old_clipboard
    execute 'Ag' selection
endfunction

function! SearchWithAgInDirectory(...)
    call fzf#vim#ag(join(a:000[1:], ' '), extend({'dir': a:1}, g:fzf#vim#default_layout))
endfunction
command! -nargs=+ -complete=dir AgIn call SearchWithAgInDirectory(<f-args>)

""""""""""""""""""""""""""
""""""" APPEARANCE """""""
""""""""""""""""""""""""""
colorscheme iceberg

set encoding=utf-8 " necessary for powerline symbols to show under windows


""""""""""""""""""""""""""
"""""""" LIGHTLINE """""""
""""""""""""""""""""""""""
set laststatus=2 " always show the status bar
let g:lightline = {
      \ 'colorscheme': 'iceberg',
      \ }

"""""""""""""""""""""""""""""""""""""""""""""
"""""""" RAINBOW PARENTHESES IMPROVED """""""
"""""""""""""""""""""""""""""""""""""""""""""
let g:rainbow_active = 1

""""""""""""""""""""""""""
"""""""" ULTISNIPS """""""
""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:UltiSnipsSnippetDirectories=["C:\Neovim\bundle\vim-snippets\UltiSnips","C:\Neovim\snippets"]

let g:UltiSnipsEditSplit="vertical"

""""""""""""""""""""""""""""
"""""""" KEYBINDINGS """""""
""""""""""""""""""""""""""""
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


""""""""""""""""""""""""""""
"""""""" INDENTATION """""""
""""""""""""""""""""""""""""
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


"""""""""""""""""""""""""""""
"""""""" LINE NUMBERS """""""
"""""""""""""""""""""""""""""
set number          " Show absolute line numbers.
set relativenumber	" Show relative line numbers.


"""""""""""""""""""""""
"""""""" SEARCH """""""
"""""""""""""""""""""""
set incsearch       " While typing a search command, show immediately where the
set ignorecase
set smartcase       " Override the 'ignorecase' option if the search pattern



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
set noswapfile


""set shell=wsl
"set shell=powershell shellquote=( shellpipe=\| shellxquote= shellredir=>
"set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
"set shellredir=\|\ Out-File\ -Encoding\ UTF8
"let g:terminal_color_0  = '#2e3436'
"let g:terminal_color_1  = '#cc0000'
"let g:terminal_color_2  = '#4e9a06'
"let g:terminal_color_3  = '#c4a000'
"let g:terminal_color_4  = '#3465a4'
"let g:terminal_color_5  = '#75507b'
"let g:terminal_color_6  = '#0b939b'
"let g:terminal_color_7  = '#d3d7cf'
"let g:terminal_color_8  = '#555753'
"let g:terminal_color_9  = '#ef2929'
"let g:terminal_color_10 = '#8ae234'
"let g:terminal_color_11 = '#fce94f'
"let g:terminal_color_12 = '#729fcf'
"let g:terminal_color_13 = '#ad7fa8'
"let g:terminal_color_14 = '#00f5e9'
"let g:terminal_color_15 = '#eeeeec'

filetype plugin on
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
""" COC """



"if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
"set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    "  if (index(['vim','help'], &filetype) >= 0)
    "    execute 'h '.expand('<cword>')
    "  else
    "    call CocAction('doHover')
    "  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    "  autocmd!
    "   Setup formatexpr specified filetype(s).
    "  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    "   Update signature help on jump placeholder
    "  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" ignore packages with vimgrep
set wildignore+=**/vendor/**,**/node_modules/**


syntax match phpNiceRelation "=>" conceal cchar=⇛
syntax match phpNiceMemberSelector "\->" conceal cchar=→

set conceallevel=2
