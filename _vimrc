execute pathogen#infect()
call pathogen#helptags()

set nocompatible
set cpoptions=aABceFsmq
set guifont=Consolas:h9
set guioptions-=T

syntax on
syntax enable

"colorscheme oceandeep
"colorscheme material
colorscheme nord

filetype on
filetype indent on
filetype plugin on

set smartindent
set autoindent
set shiftwidth=4
set softtabstop=4
set tabstop=4

set nowrap

" NERDTree
let NERDTreeShowHidden=1

" Emmet
let g:user_emmet_leader_key='<C-E>' " Remap the default <C-Y> leader

" CtrlP
let g:ctrlp_working_path_mode = 'ra' " Set local working directory
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git' " Ignore unnecessary directories

set runtimepath^=C:/Program\ Files/Vim/vimfiles/bundle/ctrlp.vim

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

augroup vimscript
	autocmd!
	autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

let mapleader=','

map <leader>n :execute 'NERDTreeToggle ' . getcwd()<cr>
map <leader>o :call OpenUrlUnderCursor()<cr>
map <left> <ESC>:bp<RETURN>
map <right> <ESC>:bn<RETURN>
map <up> <ESC>:bf<RETURN>
map <down> <ESC>:bl<RETURN>

" Easier windows navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Bubble single lines
nmap <C-Up> ddkP
nmap <C-Down> ddp

" Bubble multiple lines
vmap <C-Up> xkP`[V`]
vmap <C-Down> xp`[V`]

nnoremap <leader><space> :nohls<cr>
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>
nnoremap / /\v
nnoremap ? ?\v
nnoremap <A-a> <C-a>
nnoremap <A-x> <C-x>
nnoremap <tab> >>
nnoremap <s-tab> <<

vnoremap <tab> >
vnoremap <s-tab> <
vnoremap / /\v
vnoremap ? ?\v

inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-p>

imap jj <esc>
imap <C-Return> <CR><CR><C-o>k<Tab>

cnoreabbrev W w
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev Tabe tabe
cnoreabbrev wrap set wrap
cnoreabbrev nowrap set nowrap

iab lorem Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
iab lipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.

" set backup
" set backupdir=~/vim/backup
" set directory=~/vim/swap

set nobackup
set noswapfile

set textwidth=0
set linebreak

set scrolloff=1
set sidescrolloff=1

set shortmess=aOstT

set ruler
set number
set relativenumber

set clipboard+=unnamed

set hidden

set laststatus=2
set lazyredraw
set linespace=0

set nocursorline
set nocursorcolumn

set wildmenu
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png

set showcmd
set showmode
set showmatch
set showfulltag

set visualbell
set gdefault
set backspace=indent,eol,start

set history=9999
set timeout
set timeoutlen=1000
set ttimeoutlen=100

set formatoptions+=n
set formatlistpat=^\\s*\\(\\d\\\|[-*]\\)\\+[\\]:.)}\\t\ ]\\s*

set autoread

set incsearch
set hlsearch

set ignorecase
set smartcase

set winwidth=84
set winheight=5
set winminheight=5
set winheight=999

set fileencoding=utf-8
set encoding=utf-8

set foldmethod=marker
set foldmarker={{{,}}}

" treat all numerals as decimals, regardless of whether they are padded with zeros
set nrformats=

" run gVim maximized on startup
au GUIEnter * simalt ~x

function! InsertTabWrapper()
	let col = col('.') - 1
	if !col || getline('.')[col - 1] !~ '\k'
		return "\<tab>"
	else
		return "\<c-n>"
	endif
endfunction

function! OpenUrlUnderCursor()
	let url=matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
	if url != ""
		silent exec "!open '".url."'" | redraw!
	endif
endfunction

source $VIMRUNTIME/mswin.vim

behave mswin

set diffexpr=MyDiff()

function! MyDiff()
	let opt = '-a --binary '
	if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
	if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
	let arg1 = v:fname_in
	if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
	let arg2 = v:fname_new
	if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
	let arg3 = v:fname_out
	if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
	let eq = ''
	if $VIMRUNTIME =~ ' '
		if &sh =~ '\<cmd'
			let cmd = '""' . $VIMRUNTIME . '\diff"'
			let eq = '"'
		else
			let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
		endif
	else
		let cmd = $VIMRUNTIME . '\diff'
	endif
	silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
