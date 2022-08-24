" Author: Clark Saben
" Latest Update: 8/24/22
" Programming Languages In Mind When Building:
"              1 ) Python
"              2 ) Java
"              3 ) Markdown

" ---------------------------Ian Finlayson Contributions----------------
" generates java boiler plate and autofills class w/ file name (!?) |javat
ab javat <ESC>:set paste<CR>ipublic class <C-R>=expand("%:t:r")<CR> {<CR>    public static void main(String args[]) {<CR>       !cursor!<CR><CR><CR>    }<CR>}<CR><ESC>:set nopaste<CR>?!cursor!<CR>cf!
" auto generates the boilerplate for a print statement |sop
ab sop System.out.println
ab sopf System.out.printf
" ------------------------- Plugins ------------------------------
call plug#begin('~/.config/nvim/plugged')
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'mfussenegger/nvim-dap-python'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvie/vim-flake8'
Plug 'arcticicestudio/nord-vim'
Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'vim-scripts/indentpython.vim'
Plug 'windwp/nvim-autopairs' " alternative autopair customizable file effect
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ThePrimeagen/harpoon'
Plug 'bfredl/nvim-miniyank'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
call plug#end()
" ---------------------Plugins that need removal------------------------
"https://github.com/windwp/nvim-autopairs
"Plug 'https://github.com/neoclide/coc.nvim' "autocomplete python+
"Plug 'git@github.com:fugalh/desert.vim.git'
"Plug 'dense-analysis/ale'
" ---------------------Plugin Settings-----------------------------------

" ---------------------Markdown Settings---------------------------------
let g:mkdp_refresh_slow=1
let g:mkdp_markdown_css='~/github_markdown.css'

" ---------------------Telelscope Settings-------------------------------
:lua require('telescope')
nnoremap <leader>f :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <leader>js :lua require('telescope.builtin').find_files({ search = vim.fn.input("Enter to Find File: > ")})<CR>
" ---------------------Python Debugger Settings--------------------------
:lua require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
nmap B :lua require("dap").toggle_breakpoint()<CR> <Plug>
nmap L :lua require("dap").continue()<CR>
" ---------------------Harpoon Settings--------------------------------------
nnoremap <leader>m :lua require("harpoon.mark").add_file()<CR>
nnoremap <leader>j :lua require("harpoon.ui").toggle_quick_menu()<CR>
"                -- navigates to next mark
nnoremap <leader>l :lua require("harpoon.ui").nav_next()<CR>   
"                -- navigates to previous mark
nnoremap <leader>k:lua require("harpoon.ui").nav_prev()<CR>   

" ---------------------Autopairs settings------------------------------------
lua << EOF
require("nvim-autopairs").setup ({
  disable_filetype = { "TelescopePrompt", "vim"},
})
EOF
" ---------------------NERDTree settings-------------------------------------
nnoremap <leader>q :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"


" -------------------------- General Settings -------------------------------
let mapleader = " " "shift space
"-----Colorscheme----                            
colorscheme nord
" ----Preference----
set foldlevel=99
nnoremap <leader>g za
filetype plugin indent on
set noerrorbells
set scrolloff=8
set nowrap
set incsearch
set signcolumn=yes
set nu
set number
set cursorline
set colorcolumn=81
set incsearch
set hlsearch
set hls is "highlights word as typed in search 
set undofile "set undodir=~/.vim/undodir
set undodir=~/undodir
set mouse=a
set foldmethod=manual " <leader>zf + #jk to make and <leader>g to open
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

" -----------------Not Currently Active (rest in tmp file)----------------

"let g:ale_linters = {'python': ['flake8']}
"-----Status-line---- temporarily off bc airline works well enough
"set statusline=
"set statusline+=%#PmenuSel#
"set statusline+=\ %M "tells you what you've changed since entering buffer
"set statusline+=\ %y "tells you the file type you are in
"set statusline+=\ %r
"set statusline+=\ %F
"set statusline+=%= "Right side settings
"set statusline+=\ %p%%

