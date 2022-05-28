"VIM NOTES: https://vimhelp.org/vim_faq.txt.html#faq-15.6
" ctrl-v , select a region, shift-> to indent, gv to reselect same regioni
" more gems in that URL

vnoremap <S-s-k>   :m '<-2<CR>gv=gv
vnoremap <S-s-j> :m '>+1<CR>gv=gv

nnoremap <TAB> >>
nnoremap <S-TAB> <<
vnoremap <TAB> >gv
vnoremap <S-TAB> <gv
                            
"turn on line numbering
set number

"fix python indent issue
filetype indent on

set cursorline

set tabstop=4
"filetype plugin indent on

set incsearch

set shiftwidth=4

set tabstop=4
"expandtab is if you like spaces (finlayson does which is why he keeps it on)
set expandtab
"this is fine, it just keeps your indentation level until you manually break it off
"set autoindent

filetype plugin on
autocmd FileType python setlocal noexpandtab shiftwidth=4 softtabstop=4

set hlsearch

"this maps shift-b to run a python script from an open vim instance
autocmd FileType python map <buffer> <S-b> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <S-b> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
"a potential failure of this: shift-b will automatically write the changes.

"fix the above oversight by setting persistent undo
set undofile
"set undodir=~/.vim/undodir
set undodir=~/undodir
"this allows me to do g- from normal mode to go back to past file versions
"g+ should go forward but i must be doing it wrong b/c it doesnt always work


"allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

"nnoremap -e 'clear Lock' -e 'keycode 0x42 = Escape'
