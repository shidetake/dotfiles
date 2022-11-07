echomsg '.vimrc'

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

let $MYVIMRC = "~/.vimrc"

if has('win64')
  set shell=C:\Windows\system32\cmd.exe
endif

" read vimrc_example
"if !has('nvim')
"  source $VIMRUNTIME/vimrc_example.vim
"endif

" マウスホイールでスクロール
"if !has('nvim')
"    set ttymouse=xterm2
"endif
map <ScrollWheelUp> <C-Y>
map <S-ScrollWheelUp> <C-U>
map <ScrollWheelDown> <C-E>
map <S-ScrollWheelDown> <C-D>

" comment
map fc <Plug>(func_comment)

" ビープ音を消す
set visualbell t_vb=

" 行数表示
set number

" 最後のカーソル位置で開始
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

" インクリメンタルサーチ
set incsearch

" vim diff color
hi DiffAdd      ctermfg=black ctermbg=2
hi DiffChange   ctermfg=black ctermbg=3
hi DiffDelete   ctermfg=black ctermbg=6
hi DiffText     ctermfg=black ctermbg=7

" tab/indent
set tabstop=2
set shiftwidth=2
set expandtab
set softtabstop=0

" disable suto break
autocmd FileType text setlocal textwidth=0

" encoding
set fenc=cp932
"set fenc=utf-8
set fencs=guess,utf-8,iso-2022-jp,cp932

" Neovimの日本語入力文字化け対策。最新では修正されているようだが、しばらく入れておく
set ttimeout
set ttimeoutlen=50

" filer
" tree view
let g:netrw_liststyle = 3
le g:netrw_altv = 1

" タイトルバーにファイル名を表示
set title

" ファイル名補完
set wildmode=list:longest

set showcmd

" line number
set nu

" IME
set iminsert=0
set imsearch=-1

" search
set hlsearch

" wrap
set nowrap

if has('persistent_undo') && !&diff
  set undodir=~/.vim/undo
  set undofile
endif

" mouse
set mouse=a

" diff
set diffopt=filler ", iwhite

set helplang=ja,en

" statusline
set laststatus=2
let g:lightline = {
        \ 'colorscheme': 'jellybeans',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode'
        \ }
        \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" bracket
inoremap {<Enter> {}<Left><CR><ESC><s-o>
inoremap [<Enter> []<Left><CR><ESC><s-o>
inoremap (<Enter> ()<Left><CR><ESC><s-o>

" matchit
runtime macros/matchit.vim

" gtags
let Gtags_Auto_Map = 1
let Gtags_Auto_Update = 1
nnoremap <expr> <s-F7> ':Gtags -r \<' . expand("<cword>") . '\><CR>'

nnoremap [gtags] <Nop>
nmap <Space>t [gtags]
nnoremap <silent> [gtags]c :!gtags<CR>
nnoremap <silent> [gtags]p :!gtags --gtagslabel=pygments<CR>

" key map
imap <c-j> <esc>
nnoremap <c-h> <c-o>
nnoremap <c-l> <c-i>

"-------------------------------------------------------------------------------
" タブのクローンを作る
"-------------------------------------------------------------------------------
nnoremap <c-t> :call CloneTab()<CR>
function! CloneTab()
    let g = line('.')
    execute ":tabe %"
    execute ":" .g
endfunction

" date
nnoremap <c-o><c-o> <esc>a<c-r>=strftime("%Y-%m-%d %H:%M:%S")<CR>

" trim
nnoremap <s-l> :call Trim()<CR>$
function! Trim()
    execute "s/\ *$/"
    execute ":noh"
endfunction


" backup
set nobackup
set backupskip=/tmp/*,/private/tmp/*

"dein Scripts-----------------------------
let g:cache_home = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let g:config_home = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME

let s:dein_cache_dir = g:cache_home . '/dein'

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

if &runtimepath !~# '/dein.vim'
  let s:dein_repo_dir = s:dein_cache_dir . '/repos/github.com/Shougo/dein.vim'

  " Auto Download
  if !isdirectory(s:dein_repo_dir)
    call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
  endif

  " dein.vim をプラグインとして読み込む
  execute 'set runtimepath^=' . s:dein_repo_dir
endif

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
if dein#load_state(s:dein_cache_dir)
  call dein#begin(s:dein_cache_dir)

  " Let dein manage dein
  " Required:
  call dein#add(s:dein_repo_dir)

  " Add or remove your plugins here:
  "call dein#add('Shougo/neosnippet.vim')
  "call dein#add('Shougo/neosnippet-snippets')
  call dein#add('rking/ag.vim')
  call dein#add('vim-scripts/gtags.vim')
  "call dein#add('Shougo/neocomplcache')
  "if has('nvim')
    call dein#add('Shougo/deoplete.nvim')
  "endif
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/unite-build')
  call dein#add('Shougo/vimshell')
  call dein#add('Shougo/vinarise')
  call dein#add('astashov/vim-ruby-debugger')
  call dein#add('itchyny/lightline.vim')
  "call dein#add('vim-scripts/taglist.vim')
  call dein#add('tyru/current-func-info.vim')
  call dein#add('tyru/open-browser.vim')
  call dein#add('thinca/vim-quickrun')
  call dein#add('thinca/vim-localrc')
  call dein#add('thinca/vim-fontzoom')
  call dein#add('tpope/vim-fugitive')
  call dein#add('kannokanno/previm')
  "call dein#add('kannokanno/previm', '27-fix-rst2html-on-windows')
  "call dein#add('mopp.next-alter.vim')
  call dein#add('kana/vim-altr')
  "call dein#add('heavenshell/vim-quickrun-hook-sphinx')
  "call dein#add('kien/ctrlp.vim')
  "call dein#add('w0rp/ale')
  call dein#add('shidetake/ale', { 'rev': 'ghdl' })
  call dein#add('h1mesuke/vim-alignta')
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
  "call dein#add('shidetake/to-colored-html.vim')
  call dein#add('vim-jp/vimdoc-ja')
  call dein#add('t9md/vim-quickhl')
  call dein#add('rhysd/vim-clang-format')

    " colorscheme
  call dein#add('ujihisa/unite-colorscheme')
  call dein#add('tomasr/molokai')
  call dein#add('w0ng/vim-hybrid')
  call dein#add('nanotech/jellybeans.vim')
  call dein#add('altercation/vim-colors-solarized')

  " You can specify revision/branch/tag.
  "call dein#add('Shougo/vimshell', { 'rev': '3787e5' })
  
  " local
  "call dein#add('~/playground/vim/plugin/hello')
  "call dein#add('~/github/to-colored-html.vim')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" quickrun
nnoremap [quickrun] <Nop>
nmap <Space>q [quickrun]

let s:hook = {'name': 'make_exec', 'kind': 'hook', 'config': {'enable': 0}}
function! s:hook.on_success(session, context)
    :Quickrun exec_only
endfunction
call quickrun#module#register(s:hook, 1)
unlet s:hook

let s:hook = {'name': 'exist_makefile', 'kind': 'hook', 'config': {'enable': 0}}
function! s:hook.on_module_loaded(session, context)
    if filereadable('makefile')
        Quickrun make
    else
        QuickRun
    endif
endfunction
call quickrun#module#register(s:hook, 1)
unlet s:hook

let g:quickrun_config = {}
let g:quickrun_config._ = { 'runner': 'vimproc', 'runner/vimproc/updatetime': 10 }
let g:quickrun_config['graph'] = { 'command': 'graph-easy' }
let g:quickrun_config['ruby.rspec'] = { 'command': 'rspec', 'exec': '%c %o %s:%{line(".")}' }
let g:quickrun_config['blockdiag'] = { 'runner': 'system', 'command': 'blockdiag', 'exec': ['%c %s', 'i_view32 % {expand("%:p:r")}.png'], 'outputter': 'message' }
let g:quickrun_config['rst'] = { 'command': 'make', 'cmdopt': 'html' }
let g:quickrun_config['cpp'] = { 'type': 'cpp/clang++' }
let g:quickrun_config['c'] = { 'type': 'c/gcc' }
let g:quickrun_config.make = { 'command': 'make', 'exec': '%c', 'hook/make_exec/enable': 1, 'hook/output_encode/enable': 1, 'hook/output_encode/encoding': 'cp932' }
let g:quickrun_config.make_only = { 'command': 'make', 'exec': '%c', 'hook/output_encode/enable': 1, 'hook/output_encode/encoding': 'cp932' }
let g:quickrun_config.exec_only = { 'command': expand('%:p:r'), 'exec': '%c', 'hook/output_encode/enable': 1 }
let g:quickrun_config.cpp_procon = { 'type': 'cpp', 'command': 'g++', 'cmdopt': '../gtest/gtest-all.cc ../gtest/gtest_main.cc' }
let g:quickrun_config.cpp_make = { 'command': '', 'hook/exist_makefile/enable': 1, 'hook/output_encode/enable': 1, 'hook/output_encode/encoding': 'cp932' }
let g:quickrun_config.c_exe = { 'command': 'g++', 'exec': '%c %s', 'hook/output_encode/enable': 1, 'hook/output_encode/encoding': 'cp932' }
let g:quickrun_config.html = { 'command': 'cat', 'outputter': 'browser' }
let g:quickrun_config.python = {'hook/output_encode/enable' : 1, 'hook/output_encode/encoding' : 'utf-8:utf-8'}
nnoremap <silent> [quickrun]r :QuickRun<CR>
nnoremap <silent> [quickrun]x :QuickRun cpp_procon<CR>
nnoremap <silent> [quickrun]m :QuickRun make_only<CR>
nnoremap <silent> [quickrun]mr :QuickRun cpp_make<CR>

" previm
let g:previm_open_cmd = ''
nnoremap [previm] <Nop>
nmap <Space>p [previm]
nnoremap <silent> [previm]o: <c-u>PrevimOpen<CR>
nnoremap <silent> [previm]r: call previm#refresh()<CR>

" vimrc
command! Ev edit $MYVIMRC
command! Rv source $MYVIMRC

" unite
nnoremap [unite] <Nop>
nmap <Space>u [unite]

let g:unite_source_history_yank_enable = 1

" keymap
nnoremap <silent> [unite]u :<c-u>Unite<Space>file<CR>
nnoremap <silent> [unite]b :Unite<Space>build<CR>

" ag
nnoremap <silent> [unite]g :Unite -auto-preview -tab -no-empty grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> [unite]wg :Unite -auto-preview -tab -no-empty grep:. -w -buffer-name=search-buffer<CR>
nnoremap <silent> [unite]r :UniteResume -buffer-name=search-buffer<CR>
if executable('pt')
    let g:unite_source_grep_command = 'pt'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --ignore-case --vcs-ignore ~/.ptignore'
    let g:unite_source_grep_recursive_opt = ''
    let g:unite_source_grep_encoding = 'utf-8'
endif

" tab
nnoremap [Tag] <nop>
nmap t [Tag]
for n in range(1, 9)
    execute 'nnoremap <silent> [Tag]'.n ':<c-u>tabnext'.n.'<CR>'
endfor

nnoremap <silent> tm :<c-u>call MoveToNewTab()<CR>

function! MoveToNewTab()
    tab split
    tabprevious

    if winnr('$') > 1
        close
    elseif bufnr('$') > 1
        buffer #
    endif

    tabnext
endfunction

" no comment with CR
"set runtimepath+=~/.vim/after

" filetype
au BufNewFile, BufRead *.{md, mdwn, mkd, mkdn, mark*} set filetype=markdown
au BufNewFile, BufRead *.graph set filetype=graph
au BufNewFile, BufRead *_spec.rb set filetype=ruby.rspec
au BufNewFile, BufRead *.diag set filetype=blockdiag
au BufNewFile, BufRead *.cls set filetype=vb

" vimshell
nnoremap <silent> ! :VimShellTab<CR>

" comment
nnoremap fc :CommentWrite<CR>

" Use deoplete.
"if has('nvim')
  let g:deoplete#enable_at_startup = 1

  inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <silent><expr> <CR> pumvisible() ? deoplete#close_popup() : "\<CR>"
"endif

" fugitive
nnoremap [fugitive] <nop>
nmap <Space>g [fugitive]

" keymap
nnoremap <silent> [fugitive]b :Git blame -w<CR>
nnoremap <silent> [fugitive]d :Gdiff<CR>
nnoremap <silent> [fugitive]s :Gstatus<CR>
nnoremap <silent> [fugitive]w :Gwrite<CR>

" vim-altr
nnoremap [altr] <nop>
nmap <Space>a [altr]

nmap [altr]l <Plug>(altr-forward)
nmap [altr]h <Plug>(altr-back)

call altr#define('autoload/%.vim', 'doc/%.txt', 'plugin/%.vim')

" vim-alignta
vnoremap [alignta] <nop>
vmap <space>a [alignta]
vnoremap <silent> [alignta]\| :Alignta \|<CR>
vnoremap <silent> [alignta]c :Alignta \:<CR>

" Vinarise
"let g:vinarise_enable_auto_detect = 1

" colorscheme
if !has("win32")
    colorscheme jellybeans
end

" to-colored-html
let g:tocoloredhtml_color = 'louver'
let g:tocoloredhtml_bg = 'light'

" ale
let g:ale_vhdl_ghdl_options = '--mb-comments --ieee=synopsys'

" quickhl
nmap <Space>m <Plug>(quickhl-manual-this-whole-word)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)
