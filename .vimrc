syntax on
filetype plugin indent on
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set autoindent
set splitbelow
set splitright
set expandtab
set mouse=a

set termguicolors
set background=dark

" set clipboard=unnamedplus
set clipboard^=unnamedplus

vnoremap <C-c> "+y
nnoremap <C-c> "+y
vnoremap <C-x> "+d
nnoremap <C-x> "+d

call plug#begin('~/.vim/plugged')

Plug 'vim-scripts/Align'
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'benzanol/vim-imager'

call plug#end()

set isfname+=(,)
set isfname+=)
set isfname+=\\

function! GetCfile()
  let save_a = @a
  let @a = ''
  silent! normal "ayi"
  if @a != ''
    let file = @a
  else
    let file = expand('<cfile>')
  endif
  let @a = save_a
  let file = substitute(file, '\\\(.\)', '\1', 'g')
  let file = expand(file, 1)
  return file
endfunction

nnoremap <C-k> :call system('feh --scale-down ' . shellescape(GetCfile()) . ' &')<CR>

let g:Hexokinase_highlighters = ['backgroundfull']
let g:Hexokinase_optInPatterns = 'full_hex,triple_hex,rgb,rgba,hsl,hsla,colour_names'

" colorscheme GruberDarker
colorscheme hemisu
" colorscheme naysayer 

source $VIMRUNTIME/mswin.vim
behave mswin

nnoremap <C-_> :Commentary<CR>
vnoremap <C-_> :Commentary<CR>

let mapleader = ","

nnoremap <C-p> :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :Rg<CR>

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

nnoremap q <Nop>
nnoremap q: q:

set rtp+=/usr/share/vim/vimfiles

if executable('fd')
  let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
endif

let g:NERDTreeMinimalUI = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeAutoDeleteBuffer = 1