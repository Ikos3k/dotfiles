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

function! HandleImagePreview()
  let file_or_hash = GetCfile()
 
  if file_or_hash =~? '^[0-9a-f]\{64}$'
    let cwd = getcwd()
   
    let find_cmd = 'find "' . cwd . '" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" -o -name "*.bmp" -o -name "*.webp" -o -name "*.svg" -o -name "*.heic" \) 2>/dev/null'
    let image_files = split(system(find_cmd), '\n')
   
    if empty(image_files)
      echo "No image files found in " . cwd
      return
    endif
   
    echo "Searching " . len(image_files) . " images for hash: " . file_or_hash
   
    for image_file in image_files
      let image_file = substitute(image_file, '\s*$', '', '')
     
      let hash_cmd = 'sha256sum "' . image_file . '" 2>/dev/null'
      let hash_output = system(hash_cmd)
     
      if v:shell_error == 0 && !empty(hash_output)
        let file_hash = split(hash_output)[0]
       
        if file_hash ==# file_or_hash
          echo "Found: " . image_file
          call system('nohup feh --scale-down "' . image_file . '" >/dev/null 2>&1 &')
          return
        endif
      endif
    endfor
   
    echo "No image found with hash: " . file_or_hash
   
  else
    echo "Opening file: " . file_or_hash
    call system('nohup feh --scale-down ' . shellescape(file_or_hash) . ' >/dev/null 2>&1 &')
  endif
endfunction

nnoremap <C-k> :call HandleImagePreview()<CR>

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