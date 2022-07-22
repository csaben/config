" ; and , to scroll through the find
" ------------------------- Plugins ------------------------------
call plug#begin('~/.config/nvim/plugged')
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
"Plug 'dense-analysis/ale'
Plug 'nvie/vim-flake8'
Plug 'arcticicestudio/nord-vim'
"Plug 'https://github.com/neoclide/coc.nvim' "autocomplete python+
"Plug 'git@github.com:fugalh/desert.vim.git'
Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'vim-scripts/indentpython.vim'
Plug 'windwp/nvim-autopairs' " alternative autopair customizable file effect
"https://github.com/windwp/nvim-autopairs
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

:lua require('telescope')

" ------------------------- Plugins Settings -------------------------------
let mapleader = " " "shift space

lua << EOF
require("nvim-autopairs").setup ({
  disable_filetype = { "TelescopePrompt", "vim"},
})
EOF


"nnoremap <leader>hs :Telescope <Enter> grep_string 
nnoremap <leader>f :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <leader>js :lua require('telescope.builtin').find_files({ search = vim.fn.input("Enter to Find File: > ")})<CR>
"for reasons unknown to mankind, the appropriate lua builtins don't save to a
"place that they can be properly referenced; probably a wsl issue
nnoremap <leader>d :NERDTreeFocus<CR>
nnoremap <leader>n :NERDTree<CR>
"use q to exit nerdtree
nnoremap <leader>q :NERDTreeToggle<CR>
"nnoremap <S-h> :call CocActionAsync('jumpDefinition')<CR>
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
" -------------------------- General Settings ------------------------------
"-----Colorscheme----                            
colorscheme nord
"colorscheme desert
" ----Preference----
set noerrorbells
set nowrap
set incsearch
set signcolumn=yes
"set relativenumber
set nu
set number
set cursorline
set colorcolumn=81
set incsearch
set hlsearch
set hls is "highlights word as typed in search 
"fix the above oversight by setting persistent undo
set undofile "set undodir=~/.vim/undodir
set undodir=~/undodir
set mouse=a
"----Indentation----
"set tabstop=4
"set shiftwidth=4
"set tabstop=4
"set expandtab
"----Mappings----
vnoremap <S-s-k>   :m '<-2<CR>gv=gv
vnoremap <S-s-j> :m '>+1<CR>gv=gv
nnoremap <TAB> >>
nnoremap <S-TAB> <<
vnoremap <TAB> >gv
vnoremap <S-TAB> <gv
nnoremap <C-p> :Files<Cr>
cmap w!! w !sudo tee > /dev/null %
"----Pythonic----
"syntax on
filetype indent on
"filetype plugin on
autocmd FileType python setlocal noexpandtab shiftwidth=4 softtabstop=4
"this maps shift-b to run a python script from an open vim instance
autocmd FileType python map <buffer> <leader><S-b> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
"autocmd FileType python imap <buffer> <S-b> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
au BufNewFile,BufRead *.py
    \ set softtabstop=4 |
    \ set expandtab ts=4 sw=4 ai |
    \ set textwidth=99 | "arbitrary
    \ set fileformat=unix
    " \ set autoindent |
"let g:ale_linters = {'python': ['flake8']}
"-----Status-line----
"set statusline=
"set statusline+=%#PmenuSel#
"set statusline+=\ %M "tells you what you've changed since entering buffer
"set statusline+=\ %y "tells you the file type you are in
"set statusline+=\ %r
"set statusline+=\ %F
"set statusline+=%= "Right side settings
"set statusline+=\ %p%%

