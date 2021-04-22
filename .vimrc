scriptencoding utf-8

syntax enable
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" Give more space for displaying messages.
set cmdheight=2 " Better display for messages


" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

"" Don't give |ins-completion-menu| messages.
set shortmess+=c

"" Colors and Themes
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif


"" Always show signcolumns
set signcolumn=yes

" <leader>
let mapleader = "\<Space>"

" Copy to and paste from the system clipboards 
set clipboard=unnamed,unnamedplus

" The mouse can be used to select within Vim
set mouse=a

" line numbering setup
set number
set relativenumber

" show existing tab with 2 spaces width
set tabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2
" Sets the number of columns for a TAB
set softtabstop=2
" On pressing tab, insert spaces
set expandtab
" Toggle between paste option in insert mode
set pastetoggle=<F2>
" ignore case in searches until you enter an uppercase letter 
set ignorecase
set smartcase

" Always display x lines above or below the cursor
set scrolloff=5

" allw the cursor to go over the line limit in block mode
set virtualedit=block

" Turn on line wrapping
set wrap
set linebreak
set list  " list disables linebreak
set showbreak=↪

set textwidth=0
set wrapmargin=0

" to make Vim automatically refresh any files that haven't been edited by Vim. Also see :checktime.
" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
augroup refresh_file_from_disk
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
  " Notification after file change
  " https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
  autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
augroup END

" Uncomment the following to have Vim jump to the last position when reopening a file
if has('autocmd')
  augroup jump_to_last_position
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  augroup END
endif

" Ctrl-S to save files. Needs stty -ixon on your .bashrc file
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" Allows you to press jk or kj to exit from insert mode
inoremap jk <Esc>
inoremap kj <Esc>
inoremap <C-L> <Esc>
augroup change_timeout
  autocmd InsertEnter * set timeoutlen=200
  autocmd InsertLeave * set timeoutlen=1000
augroup END

" Always autosave everything
augroup autosave
  au FocusLost * :wa
augroup END

" Spellchecking for markdown files
augroup markdown_spelling
  au FileType markdown setl spell spelllang=en_gb
augroup END

" Log files with bug lines should still syntax highlight properly
set synmaxcol=3000
augroup logs_and_json
  au FileType log setl synmaxcol=3000 "j FIXME if 0 is too big, lets try something else
  au FileType markdown setl synmaxcol=3000 "j FIXME if 0 is too big, lets try something else
augroup END

" setup vim splits
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" column witdh to 120 characters
augroup linelength
  if exists('+colorcolumn')
    set colorcolumn=120
  else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>120v.\+', -1)
  endif
augroup END

" Change to the directory of the current file
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" Python
augroup python
  autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>
augroup END

" XML/HTML
runtime macros/matchit.vim

" # Open gz files
augroup gzip
 autocmd!
 autocmd BufReadPre,FileReadPre *.gz set bin
 autocmd BufReadPost,FileReadPost   *.gz '[,']!gunzip
 autocmd BufReadPost,FileReadPost   *.gz set nobin
 autocmd BufReadPost,FileReadPost   *.gz execute ":doautocmd BufReadPost " . expand("%:r")
 autocmd BufWritePost,FileWritePost *.gz !mv <afile> <afile>:r
 autocmd BufWritePost,FileWritePost *.gz !gzip <afile>:r
 autocmd FileAppendPre      *.gz !gunzip <afile>
 autocmd FileAppendPre      *.gz !mv <afile>:r <afile>
 autocmd FileAppendPost     *.gz !mv <afile> <afile>:r
 autocmd FileAppendPost     *.gz !gzip <afile>:r
augroup END

" # Open Zip, Jar, War, Ear file edit in vim
augroup edit_zip_files_in_vim
  au BufRead,BufNewFile *.jar,*.war,*.ear,*.sar,*.rar set filetype=zip
augroup END


" # Markdown preview
" Open markdown files with Chrome.
augroup preview_markdown_in_chrome
  autocmd BufEnter *.md execute 'noremap <F5> :!open -a /Applications/Firefox.app/Contents/MacOS/firefox-bin %<CR>'
augroup END

augroup pandoc_syntax
  autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
augroup END

" Scala specific key mappings
inoremap M< =>
inoremap ,m <-
inoremap m, ->

" # Vim Plug
call plug#begin()
  " ## General Setup
  " Vim sensible to get backspace across lines, syntax highlighting and other stuff 
  Plug 'tpope/vim-sensible'

  Plug 'itchyny/lightline.vim'

  Plug 'dense-analysis/ale'
  " Show 5 lines of errors (default: 10)
  let g:ale_list_window_size = 5
  let g:ale_linters = {'haskell': ['hlint', 'ghc',], 'scala': ['scalafmt']}
  let g:ale_haskell_ghc_options = '-fno-code -v0 -isrc'
  let g:ale_set_balloons = 1

  " This was the plugin that took more startup time
  Plug 'neomake/neomake'

  Plug 'sbdchd/neoformat'

  " Theme
  Plug 'tomasr/molokai'

  Plug 'sainnhe/sonokai'

  " ## Movement
  Plug 'haya14busa/incsearch.vim'
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)

  Plug 'haya14busa/incsearch-easymotion.vim'
  map z/ <Plug>(incsearch-easymotion-/)
  map z? <Plug>(incsearch-easymotion-?)
  map zg/ <Plug>(incsearch-easymotion-stay)

  Plug 'easymotion/vim-easymotion'
  " You can use other keymappings like <C-l> instead of <CR> if you want to
  " use these mappings as default search and sometimes want to move cursor with
  " EasyMotion.
  let g:EasyMotion_smartcase = 1
  function! s:incsearch_config(...) abort
    return incsearch#util#deepextend(deepcopy({
    \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
    \   'keymap': {
    \     "\<CR>": '<Over>(easymotion)'
    \   },
    \   'is_expr': 0
    \ }), get(a:, 1, {}))
  endfunction

  noremap <silent><expr> /  incsearch#go(<SID>incsearch_config())
  noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
  noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))
  nmap s <Plug>(easymotion-s2)
  nmap t <Plug>(easymotion-t2)
  map  / <Plug>(easymotion-sn)
  omap / <Plug>(easymotion-tn)

  " These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
  " Without these mappings, `n` & `N` works fine. (These mappings just provide
  " different highlight method and have some other features )
  map  n <Plug>(easymotion-next)
  map  N <Plug>(easymotion-prev)
  map <Leader>l <Plug>(easymotion-lineforward)
  map <Leader>j <Plug>(easymotion-j)
  map <Leader>k <Plug>(easymotion-k)
  map <Leader>h <Plug>(easymotion-linebackward)

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  map ; :Files<CR>

  Plug 'Houl/repmo-vim'

  " map a motion and its reverse motion:
  :noremap <expr> h repmo#SelfKey('h', 'l')|sunmap h
  :noremap <expr> l repmo#SelfKey('l', 'h')|sunmap l

  " if you like `:noremap j gj', you can keep that:
  :map <expr> j repmo#Key('gj', 'gk')|sunmap j
  :map <expr> k repmo#Key('gk', 'gj')|sunmap k

  " repeat the last [count]motion or the last zap-key:
  :map <expr> ; repmo#LastKey(';')|sunmap ;
  :map <expr> , repmo#LastRevKey(',')|sunmap ,

  " add these mappings when repeating with `;' or `,':
  :noremap <expr> f repmo#ZapKey('f')|sunmap f
  :noremap <expr> F repmo#ZapKey('F')|sunmap F
  :noremap <expr> t repmo#ZapKey('t')|sunmap t
  :noremap <expr> T repmo#ZapKey('T')|sunmap T

  " ## Tools

  " Jira
  Plug 'n0v1c3/vira', { 'do': './install.sh' }

  " Firefox Ghosttext
  Plug 'subnut/nvim-ghost.nvim', {'do': ':call nvim_ghost#installer#install()'}

  Plug 'trapd00r/vidir'

  Plug 'AndrewRadev/linediff.vim'

  Plug 'rickhowe/diffchar.vim'

  Plug 'tpope/vim-fugitive'

  Plug 'tpope/vim-rhubarb'

  Plug 'airblade/vim-gitgutter'
  let g:gitgutter_max_signs = 3000

  " I do not seem to be using tags
  " Plug 'ludovicchabant/vim-gutentags'

  Plug 'tpope/vim-unimpaired'

  Plug 'tpope/vim-repeat'

  Plug 'tpope/vim-surround' " ideavim has a similar extension

  Plug 'AndrewRadev/linediff.vim'

  Plug 'jremmen/vim-ripgrep'

  Plug 'mbbill/undotree'
  nnoremap <F5> :UndotreeToggle<cr>
  if has('persistent_undo')
      set undodir="".$HOME."/.undodir"
      set undofile
  endif

  Plug 'tomtom/tcomment_vim'

  " Open fileformat.info page about character on current cursor / given character
  Plug 'tyru/open-browser-unicode.vim'

  " ## Navigation and directories

  " enhances netrw
  Plug 'tpope/vim-vinegar'

  " Directory Tree view 
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  let g:NERDTreeGitStatusIndicatorMapCustom = {
      \ 'Modified'  : '✹',
      \ 'Staged'    : '✚',
      \ 'Untracked' : '✭',
      \ 'Renamed'   : '➜',
      \ 'Unmerged'  : '═',
      \ 'Deleted'   : '✖',
      \ 'Dirty'     : '✗',
      \ 'Clean'     : '✔︎',
      \ 'Ignored'   : '☒',
      \ 'Unknown'   : '?'
      \ }

  " ## Markdown
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'
  " disable the folding configuration:
  let g:vim_markdown_folding_disabled = 1
  " Allow for the TOC window to auto-fit when it's possible for it to shrink. It never increases its default size 
  " (half screen), it only shrinks.
  let g:vim_markdown_toc_autofit = 1
  " Fenced code block languages
  let g:vim_markdown_fenced_languages = [
      \'csharp=cs',
      \'c++=cpp',
      \'viml=vim',
      \'bash=sh',
      \'ini=dosini',
      \]
  " Follow named anchors
  let g:vim_markdown_follow_anchor = 1
  " LaTeX math syntax extension
  let g:vim_markdown_math = 1
  " YAML Front Matter
  let g:vim_markdown_frontmatter = 1
  " TOML Front Matter
  let g:vim_markdown_toml_frontmatter = 1
  " JSON Front Matter
  let g:vim_markdown_json_frontmatter = 1
  " Strikethrough -> uses two tildes. ~~Scratch this.~~
  let g:vim_markdown_strikethrough = 1
  " Adjust new list item indent
  let g:vim_markdown_new_list_item_indent = 2
  " Do not require .md extensions for Markdown links
  let g:vim_markdown_no_extensions_in_markdown = 1
  let g:vim_markdown_autowrite = 1

  Plug 'dhruvasagar/vim-table-mode'
  " For Markdown-compatible tables use
  let g:table_mode_corner='|'
  let g:table_mode_align_char=':'
  " quickly enable / disable table mode in insert mode by using || or __ :
  function! s:isAtStartOfLine(mapping)
    let text_before_cursor = getline('.')[0 : col('.')-1]
    let mapping_pattern = '\V' . escape(a:mapping, '\')
    let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
    return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
  endfunction
  inoreabbrev <expr> <bar><bar>
            \ <SID>isAtStartOfLine('\|\|') ?
            \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
  inoreabbrev <expr> __
            \ <SID>isAtStartOfLine('__') ?
            \ '<c-o>:silent! TableModeDisable<cr>' : '__'

  Plug 'rhysd/vim-grammarous'
  let g:grammarous#default_comments_only_filetypes = {
            \ '*' : 1, 'help' : 0, 'markdown' : 0,
            \ }


  Plug 'ferrine/md-img-paste.vim'
  autocmd FileType markdown nmap <silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
  " there are some defaults for image directory and image name, you can change them
  " let g:mdip_imgdir = 'img'
  " let g:mdip_imgname = 'image'

  " If you don't have nodejs and yarn
  " use pre build
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
  " Markdown preview mappings
  if filereadable(expand('~/.vim/my-scripts/markdown-preview-mappings.vim'))
    source ~/.vim/my-scripts/markdown-preview-mappings.vim
  endif
  " Realtime preview by Vim. (Markdown, reStructuredText, textile)
  Plug 'previm/previm'
  let g:previm_open_cmd = 'open'

  " Edit embedded markdown tables in sc-im in vim
  Plug 'mipmip/vim-scimark'


  " ## Vimwiki
  Plug 'vimwiki/vimwiki'
  let g:vimwiki_list = [{'path': '~/development/amartins-mdsol-notes/',
                        \ 'syntax': 'markdown', 'ext': '.md'}]
  " ## PlantUml
  Plug 'aklt/plantuml-syntax'
  Plug 'scrooloose/vim-slumlord'
  Plug 'weirongxu/plantuml-previewer.vim'
  au FileType plantuml let g:plantuml_previewer#plantuml_jar_path = get(
      \  matchlist(system('cat `which plantuml` | grep plantuml.jar'), '\v.*\s[''"]?(\S+plantuml\.jar).*'),
      \  1,
      \  0
      \)

  Plug 'tyru/open-browser.vim' " slow at startup

  " ## Toml
  Plug 'cespare/vim-toml'

  " # Json
  Plug 'elzr/vim-json'

  " coc.vim uses jsonc as configuration file format. It's basically json with comments support. This line gets comments highlighting
  autocmd FileType json syntax match Comment +\/\/.\+$+

  " # Yaml
  Plug 'mrk21/yaml-vim'

  " ## Shell
  Plug 'WolfgangMehner/bash-support'
  Plug 'WolfgangMehner/awk-support'
  Plug 'WolfgangMehner/vim-support'
  Plug 'dag/vim-fish'

  " ## Scala
  
  " Configuration for vim-scala
  " Plug 'derekwyatt/vim-scala'

  " au BufRead,BufNewFile *.sbt set filetype=scala

  " Use release branch (recommend)
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " coc.nvim lsp mappings
  if filereadable(expand('~/.vim/my-scripts/coc-mappings.vim'))
    source ~/.vim/my-scripts/coc-mappings.vim"
  endif
  " USE CcmdheightocInstall to install Language servers

  Plug 'GEverding/vim-hocon'

  " ## Javascript
  Plug 'pangloss/vim-javascript'
  " Enables syntax highlighting for JSDocs.
  let g:javascript_plugin_jsdoc = 1
  " Enables syntax highlighting for Flow.
  let g:javascript_plugin_flow = 1
  " You can customize concealing characters, if your font provides the glyph you want, by defining one or more of the following variables:
  let g:javascript_conceal_function             = "ƒ"
  let g:javascript_conceal_null                 = "ø"
  let g:javascript_conceal_this                 = "@"
  let g:javascript_conceal_return               = "⇚"
  let g:javascript_conceal_undefined            = "¿"
  let g:javascript_conceal_NaN                  = "ℕ"
  let g:javascript_conceal_prototype            = "¶"
  let g:javascript_conceal_static               = "•"
  let g:javascript_conceal_super                = "Ω"
  let g:javascript_conceal_arrow_function       = "⇒"
  let g:javascript_conceal_noarg_arrow_function = "🞅"
  let g:javascript_conceal_underscore_arrow_function = "🞅"
  " You can enable concealing within VIM with:
  set conceallevel=1
  map <leader>l :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>

  Plug 'jelera/vim-javascript-syntax'

  " ### Jsx
  Plug 'mxw/vim-jsx'
  let g:jsx_ext_required = 0

  " ## Typescript
  Plug 'leafgarland/typescript-vim', { 'do': 'npm -g install tsc' }
  let g:typescript_compiler_binary = 'tsc'
  let g:typescript_compiler_options = ''

  " ## GraphQL
  Plug 'jparise/vim-graphql'

  " ## CSS
  Plug 'ap/vim-css-color'

  " ## Rust
  Plug 'rust-lang/rust.vim'

  " ## Logs
  Plug 'dzeban/vim-log-syntax'

  " ## Python
  Plug 'python-mode/python-mode', { 'branch': 'develop' }
  let g:pymode_python = 'python3'

  " ## Haskell
  Plug 'neovimhaskell/haskell-vim'
  let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
  let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
  let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
  let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
  let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
  let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
  let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
  let g:haskell_indent_disable = 0 " using hindent instead
  Plug 'alx741/vim-hindent'
  Plug 'mpickering/hlint-refactor-vim'
  Plug 'parsonsmatt/intero-neovim'
  " Intero
  augroup interoMaps
    au!
    " Background process and window management
    au FileType haskell nnoremap <silent> <leader>is :InteroStart<CR>
    au FileType haskell nnoremap <silent> <leader>ik :InteroKill<CR>
  
    " Open intero/GHCi split horizontally
    au FileType haskell nnoremap <silent> <leader>ioh :InteroOpen<CR>
    " Open intero/GHCi split vertically
    au FileType haskell nnoremap <silent> <leader>iov :InteroOpen<CR><C-W>H
    " Automatically reload on save
    au BufWritePost *.hs InteroReload
  augroup END

  " ## Arduino
  Plug 'stevearc/vim-arduino'

  nnoremap <buffer> <leader>am :ArduinoVerify<CR>
  nnoremap <buffer> <leader>au :ArduinoUpload<CR>
  nnoremap <buffer> <leader>ad :ArduinoUploadAndSerial<CR>
  nnoremap <buffer> <leader>ab :ArduinoChooseBoard<CR>
  nnoremap <buffer> <leader>ap :ArduinoChooseProgrammer<CR>

  " ## HTTP
  Plug 'nicwest/vim-http'

  " ## TMUX
  Plug 'tmux-plugins/vim-tmux-focus-events'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'tmux-plugins/vim-tmux'
  " Plug 'roxma/vim-tmux-clipboard' " makes neovim slow at startup 
  " 1       4349.237   vim-tmux-clipboard
  " 2       4144.174   vim-wakatime
  " 3       3574.485   open-browser.vim

  " ## Help
  " On-demand lazy load
  Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

  " To register the descriptions when using the on-demand load feature,
  " use the autocmd hook to call which_key#register(), e.g., register for the Space key:
  autocmd! User vim-which-key call which_key#register('<Space>', 'g:which_key_map')

  " For host C02D90AYMD6M
  " Running nvim to generate startup logs... done.
  " Loading and processing logs... done.
  " Plugin directory: /Users/amartins/.vim/plugged
  " =====================================
  " Top 10 plugins slowing nvim's startup
  " =====================================
  " 1	20348.286   vim-wakatime
  " 2	117.530   nerdtree
  " let hostname=system('hostname -s')
  " echo hostname
  " if hostname != 'C03D90AYMD6M'
  "   Plug 'wakatime/vim-wakatime' " soo slow when profiling neovim startup
  " endif
call plug#end()
" colorscheme molokai

" The configuration options placed before `colorscheme sonokai`.
" Available values: `'default'`, `'atlantis'`, `'andromeda'`, `'shusia'`, `'maia'`
let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1

colorscheme sonokai
