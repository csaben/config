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

" -------------------------- jupyter experiments ------------------------

" Goal: Ultimately this will become my kaggle workspace from the terminal
" Progress: Works as intended(save auto sync ipynb), but requires legwork,
" 	    Markdown cells and Code cell rendering is straightforward

" This works fine; just would be nice if the syncing didn't require me to 
" do any legwork for every time I change a file

" generate the pair of py and ipynb (this would need to be aliased in bashrc)
" python -m jupyter_ascending.scripts.make_pair --base

" still needs to reference the current file name while <ESC> in vim buffer or
" OR potentially just alias it and only sync at the end of a work session for
" upload or to get a sneak peak at progress
" !python -m jupyter_ascending.requests.sync --filename NAME.sync.py

" if you download a notebook and want to convert it (jupytext: https://jupytext.readthedocs.io/en/latest/using-cli.html)
" ALIAS this one
" jupytext --set-formats ipynb,py NAME.ipynb

" Final wishlist item is code block navigation via cell like done here:
" https://richban.tech/python-jupyter-notebooks-development-in-neo-vim

" Sources
" Jupytext: https://github.com/mwouts/jupytext/blob/main/docs/formats.md#The-percent-format
" Jupyter Ascending: https://github.com/untitled-ai/jupyter_ascending
" Blog post 1: https://richban.tech/python-jupyter-notebooks-development-in-neo-vim
" Blog post 2: https://maxwellrules.com/misc/nvim_jupyter.html
" Blog post 3: https://expectationmax.github.io/2018/Neovim-pipenv-based-development-environment/
" Cool alternative; Magma: https://github.com/dccsillag/magma-nvim

" ------------------------- ml shortcuts abusing ab ------------------------------
" boiler plate def main() and if __name__ == '__main__':
ab mainf <ESC>:set paste<CR>idef main():<CR><Tab>pass<CR><CR><ESC>:retab<CR><ESC>:normal G<ESC>A<CR><CR><CR>if __name__ == '__main__':<CR><Tab>main()<ESC>:retab<CR><ESC>:''<CR><ESC><ESC>:set nopaste<CR><ESC>:retab<CR>?!<CR>cf!

" tf keras imports and silencing tf errors w/ os.environ ; this does assume
" you are at the spot you wanna to put your imports 
ab importf <ESC>:set paste<CR>iimport os<CR>os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'<CR>import warnings<CR>warnings.filterwarnings('ignore')<CR><CR>import tensorflow as tf<CR>from tensorflow import keras<CR>import numpy as np<CR>import pandas as pd<CR><ESC>:set nopaste<CR>?!<CR>cf!

" warnings.filterwarnings('ignore')
" boiler plate eda of a numpy array

" boiler plate keras functional model




" ------------------------- Plugins ------------------------------
call plug#begin('~/.config/nvim/plugged')

Plug 'untitled-ai/jupyter_ascending.vim'

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
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'


" If you have nodejs and yarn
call plug#end()
" ---------------------Plugins that need removal------------------------
"https://github.com/windwp/nvim-autopairs
"Plug 'https://github.com/neoclide/coc.nvim' "autocomplete python+
"Plug 'git@github.com:fugalh/desert.vim.git'
"Plug 'dense-analysis/ale'
" ---------------------Plugin Settings-----------------------------------

nmap LK <Plug>JupyterExecute

" ---------------------Markdown Settings---------------------------------
let g:mkdp_refresh_slow=1
let g:mkdp_markdown_css='~/github_markdown.css'
map N :MarkdownPreview
"map N <Plug>MarkdownPreview

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

