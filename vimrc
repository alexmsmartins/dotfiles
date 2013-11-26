call pathogen#infect()

"""""""""""""""""""""""""""""""""""
" Syntax and indent
"""""""""""""""""""""""""""""""""""
syntax on " Turn on syntax highligthing
set showmatch  "Show matching bracets when text indicator is over them

colorscheme delek

" Switch on filetype detection and loads 
" ======================================
" indent file (indent.vim) for specific file types
filetype indent on
filetype on
"alex set cindent
set autoindent " Copy indent from the row above
"alex set si " Smart indent
if has("autocmd")
    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on
    " ...
elseif
  set cindent
  "set autoindent " Copy indent from the row above
  set si " Smart indent
endif

"Toggle auto-indenting for code paste
"====================================
"The first line sets a mapping so that pressing F2 in normal mode will invert the
"'paste' option, and will then show the value of that option.
nnoremap <F2> :set invpaste paste?<CR>

"The second "line allows you to press F2 when in insert mode, to toggle 'paste' on
"and off.
set pastetoggle=<F2>

"The third line enables displaying whether 'paste' is turned on in insert mode.
set showmode


""""""""""""""""""""""""""""""""""
" Some other confy settings
""""""""""""""""""""""""""""""""""
" set nu " Number lines
set hls " highlight search
set lbr " linebreak

" Use 2 space instead of tab during format
set expandtab
set shiftwidth=2
set softtabstop=2
set cinkeys=0{,0},:,0#,!,!^F

"    7 Habits For Effective Text Editing 2.0 ->
"    http://video.google.com/videoplay?docid=2538831956647446078&ei=EqiGSau8KZ-QiQLi-Nn8Cg&q=bram+molenaar+editing"
set hlsearch
"move between windows on screen: works with up to 9 windows "
let i = 1
while i <= 9
  execute 'nnoremap <Leader>' . i . ' :' . i . 'wincmd w<CR>'
  let i = i + 1
endwhile

