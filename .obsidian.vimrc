# this vimrc file is used by the Obsidian Vimrc Support Plugin within Obsidian
# to be used, it currently needs to be copied over to the root directory of every vault
# https://github.com/esm7/obsidian-vimrc-support

" Allows you to press jk or kj to exit from insert mode
inoremap jk <Esc>
inoremap kj <Esc>
inoremap <C-L> <Esc>

" Have j and k navigate visual lines rather than logical ones
nmap j gj
nmap k gk

" Quickly remove search highlights
nmap <F9> :nohl

" Yank to system clipboard
set clipboard=unnamed

" Go back and forward with Ctrl+O and Ctrl+I
" (make sure to remove default Obsidian shortcuts for these to work)
exmap back obcommand app:go-back
nmap <C-o> :back
exmap forward obcommand app:go-forward
nmap <C-i> :forward
