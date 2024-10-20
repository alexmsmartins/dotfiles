scriptencoding utf-8
syntax enable
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

"" Don't give |ins-completion-menu| messages.
set shortmess+=c

"" Colors and Themes
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
  set termguicolors
endif


"" Always show signcolumns
set signcolumn=yes

" <leader>
let mapleader = ";" " giving ';' as leader a go.
let maplocalleader = "\<Space>" " i never use localLeader but maybe it is time to start trying it.

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

" Turn off line wrapping
" having this option on did not help view or navigate logs better
set nowrap
set linebreak
set list  " list disables linebreak
set showbreak=↪

set textwidth=0
set wrapmargin=0


" TODO delete this if not used (20211128)
" To use VIM/NeoVIM as a command line ditor in bash
augroup syntax_highlight_current_bash_command # after calling \C-e from .inputrc
  autocmd BufEnter /tmp/bash-fc.* 
    \ set syntax=bash
augroup END

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
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
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
  autocmd FocusLost * :wa
augroup END

" move between buffers
" TODO @alex try another shortcut
map <C-Tab> :bnext<cr>
map <C-S-Tab> :bprevious<cr>

" Spellchecking for markdown files
augroup markdown_spelling
  autocmd FileType markdown setl spell spelllang=en_gb
augroup END

" Log files with bug lines should still syntax highlight properly
set synmaxcol=3000
augroup logs_and_json
  autocmd FileType log setl synmaxcol=3000 "j FIXME if 0 is too big, lets try something else
  autocmd FileType markdown setl synmaxcol=3000 "j FIXME if 0 is too big, lets try something else
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
    autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>120v.\+', -1)
  endif
augroup END

" Change to the directory of the current file
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" Python
if ! has("pythonx")
  if has("nvim")
    !pip3 install neovim
  endif
endif
set pyxversion=3
augroup python
  autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>
augroup END

" XML/HTML
runtime macros/matchit.vim



" # Avro Schema
augroup avro-schema
  autocmd BufNewFile,BufRead *.avsc set filetype=json
augroup END

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
  autocmd BufRead,BufNewFile *.jar,*.war,*.ear,*.sar,*.rar set filetype=zip
augroup END

" # Markdown preview

augroup pandoc_syntax
  autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
augroup END

" Scala specific key mappings
inoremap M< =>
inoremap ,m <-
inoremap m, ->

" Python specific key mappings
set pyxversion=3

" Docker syntax highlighting
augroup docker_file
  autocmd BufNewFile,BufRead Dockerfile* set syntax=dockerfile
augroup END

" :h :DiffOrig
command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_
		\ | diffthis | wincmd p | diffthis

" # Vim Plug
call plug#begin()
  " ## General Setup
  " Fix CursorHold, CursorHoldI and updatetime Performance
  " This will result in more snappiness for plugins using those events, such as: coc.nvim, vim-gutter, tagbar, vim-devicons, vim-polyglot, etc.
  Plug 'antoinemadec/FixCursorHold.nvim'
  " Vim sensible to get backspace across lines, syntax highlighting and other stuff
  Plug 'tpope/vim-sensible'

  Plug 'itchyny/lightline.vim'

  " By the way, -- INSERT -- is unnecessary anymore because the mode information is displayed in the statusline. 
  " This config gets rid of it
  set noshowmode
  let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

  if !has('nvim')
    " disable (before plugins are loaded) LSP features in ALE, so ALE does not provide LSP features already provided by coc.nvim.
    let g:ale_disable_lsp = 1
    " we also configure coc.nvim to send diagnostics to ALE, so ALE controls how all problems are presented. 
    " Complementary ption inserted after calling :CocConfig
  endif
  Plug 'dense-analysis/ale'
  " Show 5 lines of errors (default: 10)
  let g:ale_list_window_size = 5
  " 2023-02-24 TODO @alex chekcing if HAskell works better withou ale
  " let g:ale_linters = {'haskell': ['hlint', 'ghc',], 'scala': ['scalafmt']}
  let g:ale_linters = {'scala': ['scalafmt']}
  " let g:ale_haskell_ghc_options = '-fno-code -v0 -isrc'
  let g:ale_set_balloons = 1

  " This was the plugin that took more startup time
  Plug 'neomake/neomake'

  Plug 'sbdchd/neoformat'

  " Theme
  Plug 'tomasr/molokai'
  " The configuration options placed before `colorscheme sonokai`.
  " Available values: `'default'`, `'atlantis'`, `'andromeda'`, `'shusia'`, `'maia'`
  let g:sonokai_style = 'andromeda'
  let g:sonokai_enable_italic = 1
  let g:sonokai_disable_italic_comment = 1
  Plug 'sainnhe/sonokai'
  Plug 'lifepillar/vim-solarized8'


  " ## Movement
  if has('nvim')
    " diff behaviour than in vim
    Plug 'ggandor/lightspeed.nvim'
  else
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
  endif

  " movement
  Plug 'mg979/vim-visual-multi', {'branch': 'master'}
  " Trigger a highlight in the appropriate direction when pressing these keys:
  let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

  " An always-on highlight for a unique character in every word on a line to help you use f, F and family.
  Plug 'unblevable/quick-scope'       " Plug


  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
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

  " ## Databases
  Plug 'tpope/vim-dadbod'
  Plug 'kristijanhusak/vim-dadbod-ui'

  " ## Tools

  Plug 'trapd00r/vidir'

  Plug 'AndrewRadev/linediff.vim'

  Plug 'rickhowe/diffchar.vim'

  Plug 'szw/vim-maximizer'
  nnoremap <silent><F3> :MaximizerToggle<CR>
  vnoremap <silent><F3> :MaximizerToggle<CR>gv
  inoremap <silent><F3> <C-o>:MaximizerToggle<CR>

  " Vim Terminal Help does the following:
  "  - setup a keymap ALT+=
  "  - use ALT+SHIFT+h/j/k/l to move around between windows
  "  - it provides a drop command in the internal terminal to tell outside vim to open a file
  Plug 'skywind3000/vim-terminal-help'

  " View and search LSP symbols, tags in Vim/NeoVim.
  Plug 'liuchengxu/vista.vim'

  " This plugin provides several pairs of bracket maps.
  " - ]q is :cnext. [q is :cprevious.
  " - ]a is :next. [b is :bprevious. .
  " - [<Space> and ]<Space> add newlines before and after the cursor line.
  " See the documentation in :h unimpaired for the full set of 20 mappings and mnemonics. All of them take a count
  Plug 'tpope/vim-unimpaired'
  " The . command works with all operator mappings in tpope/unimpaired, and will work with the linewise mappings as well if you install repeat.vim.
  Plug 'tpope/vim-repeat'

  " ideavim has a similar extension
  Plug 'tpope/vim-surround'
  
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


  Plug 'wakatime/vim-wakatime'

  " ## Git and other VCSs
  Plug 'tpope/vim-fugitive'

  Plug 'airblade/vim-gitgutter'
  let g:gitgutter_max_signs = 3000

  Plug 'tpope/vim-rhubarb'


  " ## Navigation and directories
  "
  " Fern Directory Tree view (drawer
  Plug 'lambdalisue/fern.vim'
  let g:fern#disable_default_mappings   = 1
  let g:fern#disable_drawer_auto_quit   = 1
  let g:fern#disable_viewer_hide_cursor = 1
  let g:fern#default_hidden = 1
  " Candidate fern launch mappings:
  noremap <silent> <Leader>d :Fern . -drawer -width=35 -toggle<CR><C-w>=
  noremap <silent> <Leader>f :Fern . -drawer -reveal=% -width=35<CR><C-w>=
  noremap <silent> <Leader>. :Fern %:h -drawer -width=35<CR><C-w>=
  function! FernInit() abort
    nmap <buffer><expr>
          \ <Plug>(fern-my-open-expand-collapse)
          \ fern#smart#leaf(
          \   "\<Plug>(fern-action-open:select)",
          \   "\<Plug>(fern-action-expand)",
          \   "\<Plug>(fern-action-collapse)",
          \ )
    nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
    nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
    nmap <buffer> m <Plug>(fern-action-mark:toggle)j
    nmap <buffer> N <Plug>(fern-action-new-file)
    nmap <buffer> K <Plug>(fern-action-new-dir)
    nmap <buffer> D <Plug>(fern-action-remove)
    nmap <buffer> C <Plug>(fern-action-move)
    nmap <buffer> R <Plug>(fern-action-rename)
    nmap <buffer> s <Plug>(fern-action-open:split)
    nmap <buffer> v <Plug>(fern-action-open:vsplit)
    nmap <buffer> r <Plug>(fern-action-reload)
    nmap <buffer> <nowait> d <Plug>(fern-action-hidden:toggle)
    nmap <buffer> <nowait> < <Plug>(fern-action-leave)
    nmap <buffer> <nowait> > <Plug>(fern-action-enter)
  endfunction
  
  augroup FernEvents
    autocmd!
    autocmd FileType fern call FernInit()
  augroup END

  Plug 'lambdalisue/fern-git-status.vim'

  " bookmarks
  Plug 'Yilin-Yang/vim-markbar'
  nmap <Leader>m <Plug>ToggleMarkbar
  Plug 'kshenoy/vim-signature'


  " ## Help
  Plug 'sudormrfbin/cheatsheet.nvim'
    " depends on
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

  " ## Syntax highlighting for several launguagents
  Plug 'sheerun/vim-polyglot'

  " Semantic syntax highlighting 
  Plug 'jaxbot/semantic-highlight.vim'

  " ## Markdown
  Plug 'bpstahlman/txtfmt'
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

  Plug 'ellisonleao/glow.nvim', {'branch': 'main'}

  " If you don't have nodejs and yarn
  " use pre build, add 'vim-plug' to the filetype list so vim-plug can update this plugin
  " see: https://github.com/iamcco/markdown-preview.nvim/issues/50
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': 'markdown' }
  " Markdown preview mappings
  if filereadable(expand('~/.vim/my-scripts/markdown-preview-mappings.vim'))
    source ~/.vim/my-scripts/markdown-preview-mappings.vim
  endif


  " ## Hashicorp related plugins
  Plug 'hashivim/vim-terraform'
  Plug 'hashivim/vim-vagrant'

  " ## Vimwiki
  " Commented in 20220228 because the <Tab> and <S-Tab> keybindings clash with Coc autocomplete
  " AND I am not using VimWiki anyway
  Plug 'vimwiki/vimwiki'
  let g:vimwiki_list = [{'path': '~/development/amartins-mdsol-notes/',
                        \ 'syntax': 'markdown', 'ext': '.md'}]

  " ## Tasks and project management
  " 20230710 Stopped using taskwarrior and taskwiki.
  " 20230710 I should remove these plugins if the need to restore them does not arise.
  " Plug 'tools-life/taskwiki' , { 'do': 'pip3 install tasklib'} " , { 'do': 'pip3 install pynvim' }
  " color support in charts.
  " Plug 'powerman/vim-plugin-AnsiEsc'
  " provides taskwiki file navigation.
  " Plug 'majutsushi/tagbar'
  " Plug 'farseer90718/vim-taskwarrior'

  " ## PlantUml
  Plug 'aklt/plantuml-syntax'
  Plug 'scrooloose/vim-slumlord'
  Plug 'weirongxu/plantuml-previewer.vim'
  autocmd FileType plantuml let g:plantuml_previewer#plantuml_jar_path = get(
      \  matchlist(system('cat `which plantuml` | grep plantuml.jar'), '\v.*\s[''"]?(\S+plantuml\.jar).*'),
      \  1,
      \  0
      \)

  Plug 'tyru/open-browser.vim'

  " ## Toml
  Plug 'cespare/vim-toml'

  " # Json
  Plug 'elzr/vim-json'

  " # CSV/TSV
  Plug 'mechatroner/rainbow_csv'

  " coc.vim uses jsonc as configuration file format. It's basically json with comments support. This line gets comments highlighting
  autocmd FileType json syntax match Comment +\/\/.\+$+

  " # Xmp
  Plug 'othree/xml.vim'

  " # Yaml
  Plug 'mrk21/yaml-vim'

  " # Avro
  Plug 'gurpreetatwal/vim-avro'

  " ## Shell
  Plug 'WolfgangMehner/bash-support'
  Plug 'WolfgangMehner/awk-support'
  Plug 'WolfgangMehner/vim-support'
  Plug 'dag/vim-fish'

  " ## Nix
  Plug 'LnL7/vim-nix'

  " ## C
  Plug 'WolfgangMehner/c-support'

  " ## Verilog
  Plug 'jmcneal/verilog-support'

  " ## VimL
  "

  " ## Scala
  " disable coc-nvim for scala type 
  " From https://github.com/neoclide/coc.nvim/issues/349
  function! s:disable_coc_for_type()
          let l:filesuffix_blacklist = ['scala', 'sbt']
  	if index(l:filesuffix_blacklist, expand('%:e')) != -1
  		let b:coc_enabled = 0
  	endif
  endfunction
  autocmd BufRead,BufNewFile * call s:disable_coc_for_type()

  " Configuration for vim-scala or nvim-metals
  if has('nvim')
    Plug 'hrsh7th/nvim-cmp'
    " depends on
      Plug 'hrsh7th/cmp-nvim-lsp'
      Plug 'hrsh7th/cmp-vsnip'
      Plug 'hrsh7th/vim-vsnip'
    Plug 'scalameta/nvim-metals'
    " depends on
      Plug 'nvim-lua/plenary.nvim'
      Plug 'mfussenegger/nvim-dap'

      " TODO @alex insert lua config here from 
      "
      nnoremap <silent> gd          <cmd>lua vim.lsp.buf.definition()<CR>
      nnoremap <silent> K           <cmd>lua vim.lsp.buf.hover()<CR>
      nnoremap <silent> gi          <cmd>lua vim.lsp.buf.implementation()<CR>
      nnoremap <silent> gr          <cmd>lua vim.lsp.buf.references()<CR>
      nnoremap <silent> gds         <cmd>lua vim.lsp.buf.document_symbol()<CR>
      nnoremap <silent> gws         <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
      nnoremap <silent> <leader>rn  <cmd>lua vim.lsp.buf.rename()<CR>
      nnoremap <silent> <leader>f   <cmd>lua vim.lsp.buf.formatting()<CR>
      nnoremap <silent> <leader>ca  <cmd>lua vim.lsp.buf.code_action()<CR>
      nnoremap <silent> <leader>ws  <cmd>lua require'metals'.worksheet_hover()<CR>
      nnoremap <silent> <leader>a   <cmd>lua require'metals'.open_all_diagnostics()<CR>
      nnoremap <silent> <space>d    <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
      nnoremap <silent> [c          <cmd>lua vim.lsp.diagnostic.goto_prev { wrap = false }<CR>
      nnoremap <silent> ]c          <cmd>lua vim.lsp.diagnostic.goto_next { wrap = false }<CR>
      
      "-----------------------------------------------------------------------------
      " nvim-lsp Settings
      "-----------------------------------------------------------------------------
      " If you just use the latest stable version, then setting this isn't necessary
      let g:metals_server_version = '0.9.8+10-334e402e-SNAPSHOT'
      
      "-----------------------------------------------------------------------------
      " nvim-metals setup with a few additions such as nvim-completions
      "-----------------------------------------------------------------------------


      " TODO @alex uncomment or move into a lua config file
      " source /Users/amartins/.vimrc.metals.lua
      
      "-----------------------------------------------------------------------------
      " completion-nvim settings
      "-----------------------------------------------------------------------------
      " Use <Tab> and <S-Tab> to navigate through popup menu
      inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
      inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
      
      "-----------------------------------------------------------------------------
      " Helpful general settings
      "-----------------------------------------------------------------------------
      " Needed for compltions _only_ if you aren't using completion-nvim
      autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc
      
      " Set completeopt to have a better completion experience
      set completeopt=menuone,noinsert,noselect
      
      " Avoid showing message extra message when using completion
      set shortmess+=c

  else
    Plug 'derekwyatt/vim-scala'
  endif
  
  autocmd BufRead,BufNewFile *.sbt set filetype=scala
  
  " Use release branch (recommend)
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  let g:coc_global_extensions = [
        \'coc-clangd',
        \'coc-db',
        \'coc-diagnostic',
        \'coc-docker',
        \'coc-fish',
        \'coc-git',
        \'coc-java',
        \'coc-java-debug',
        \'coc-json',
        \'coc-markdownlint',
        \'coc-prettier',
        \'coc-pyright',
        \'coc-rls',
        \'coc-rust-analyzer',
        \'coc-sh',
        \'coc-snippets',
        \'coc-sql',
        \'coc-sqlfluff',
        \'coc-tabnine',
        \'coc-tsserver',
        \'coc-vimlsp',
        \'coc-xml',
        \'coc-yaml',
        \]
  " coc.nvim lsp mappings
  if filereadable(expand('~/.vim/my-scripts/coc-mappings.vim'))
    source ~/.vim/my-scripts/coc-mappings.vim
  endif
  " USE CcmdheightocInstall to install Language servers
  let g:LanguageClient_serverCommands = {
    \ 'sh': ['bash-language-server', 'start']
    \ }

  " use <tab> for trigger completion and navigate to the next complete item
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction
  
  inoremap <silent><expr> <Tab>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<Tab>" :
        \ coc#refresh()

  " ## Snippets

  " When we are editing Markdown files, it is nice to have some code snippets to improve efficiency. Fortunately, UltiSnips combined with vim-snippets3 provides a lot of useful snippets for Markdown files.
  " The two plugins can be install via vim-plug:
  " Plug 'SirVer/ultisnips'
  " Plug 'honza/vim-snippets'

  " We need to set up UltiSnips to use it. The following is an example setting:
  " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
  "let g:UltiSnipsExpandTrigger="<tab>"  " use <Tab> to trigger autocompletion
  " let g:UltiSnipsJumpForwardTrigger="<c-n>"
  " let g:UltiSnipsJumpBackwardTrigger="<c-p>"

  " ## HOCON
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
  Plug 'ron-rs/ron.vim'

  " ## Logs
  Plug 'dzeban/vim-log-syntax'

  " ## Python
  Plug 'python-mode/python-mode', { 'branch': 'develop' }
  let g:pymode_python = 'python3'

  " ## R and RStudio
  Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}

  " ## Haskell
  " Plug 'neovimhaskell/haskell-vim'
  " let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
  " let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
  " let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
  " let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
  " let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
  " let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
  " let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
  " let g:haskell_indent_disable = 0 " using hindent instead
  " Plug 'neovim/nvim-lspconfig'

  " Plug 'alx741/vim-hindent'
  " Plug 'mpickering/hlint-refactor-vim'

  Plug 'mrcjkb/haskell-tools.nvim'
   " depends on
     Plug 'nvim-lua/plenary.nvim'
     Plug 'nvim-telescope/telescope.nvim' " optional


  " ## Arduino
  Plug 'stevearc/vim-arduino'

  nnoremap <buffer> <leader>am :ArduinoVerify<CR>
  nnoremap <buffer> <leader>au :ArduinoUpload<CR>
  nnoremap <buffer> <leader>ad :ArduinoUploadAndSerial<CR>
  nnoremap <buffer> <leader>ab :ArduinoChooseBoard<CR>
  nnoremap <buffer> <leader>ap :ArduinoChooseProgrammer<CR>

  " ## HTTP
  Plug 'aquach/vim-http-client'

  " ## TMUX
  Plug 'tmux-plugins/vim-tmux-focus-events'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'tmux-plugins/vim-tmux'

  autocmd BufNewFile,BufRead Dockerfile* set syntax=dockerfile
  Plug 'kkvh/vim-docker-tools'
  if !has('nvim')
    Plug 'skanehira/docker.vim'
  endif
  Plug 'skanehira/docker-compose.vim'

  " ## Other
  Plug 'frazrepo/vim-rainbow'
  let g:rainbow_active = 1
call plug#end()

set background=dark
colorscheme industry


