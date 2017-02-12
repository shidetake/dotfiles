let $MYVIMRC = "~/.vimrc"

" shell
set shell=C:\Windows\system32\cmd.exe

" tab/indent
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=0

" disable suto break
autocmd FileType text setlocal textwidth=0

" encoding
set fenc=cp932
"set fenc=utf-8
set fencs=guess,iso-2022-jp,utf-8,cp932

" filer
" tree view
let g:netrw_liststyle = 3
le g:netrw_altv = 1

" ファイル名補完
set wildmode=list:longest

" line number
set nu

" IME
set iminsert=0
set imsearch=-1

" search
set hlsearch

" wrap
set nowrap

" mouse
set mouse=a

" diff
set diffopt=filler ", iwhite

" statusline
set laststatus=2
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \}

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
" nnoremap <expr> <c-t> ':tabe %<CR>'

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

" plugin
set runtimepath+=~/.vim/
"call pathogen#incubate()
" 起動が遅くなるので読み込まない
"call pathogen#helptags()

" neobundle
" Note: Skip initialization for vim-tiny or vim-small
if !1 | finish | endif

if has ('vim_starting')
    set nocompatible

    " Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

"NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'rking/ag.vim'
NeoBundle 'vim-scripts/gtags.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-build'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vinarise'
NeoBundle 'astashov/vim-ruby-debugger'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'vim-scripts/taglist.vim'
NeoBundle 'tyru/current-func-info.vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-localrc'
NeoBundle 'thinca/vim-fontzoom'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kannokanno/previm'
"NeoBundle 'kannokanno/previm', '27-fix-rst2html-on-windows'
"NeoBundle 'mopp.next-alter.vim'
NeoBundle 'kana/vim-altr'
"NeoBundle 'heavenshell/vim-quickrun-hook-sphinx'
"NeoBundle 'kien/ctrlp.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'h1mesuke/vim-alignta'

"NeoBundle 'Shougo/vimproc.vim', {
"\ 'build' : {
"\     'windows' : 'tools\\update-dll-mingw',
"\     'cygwin' : 'make -f make_cygwin.mak',
"\     'mac' : 'make',
"\     'unix' : 'gmake',
"\    },
"\ }

NeoBundleLocal ~/.vim/myplugin

call neobundle#end()

filetype plugin indent on

NeoBundleCheck

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
"let g:quickrun_config['ruby.rspec'] = { 'command': 'bundle', 'cmdopt': 'exec rspec', 'exec': '%c %o %s:%{line(".")}' }
let g:quickrun_config['ruby.rspec'] = { 'command': 'rspec', 'exec': '%c %o %s:%{line(".")}' }
let g:quickrun_config['blockdiag'] = { 'runner': 'system', 'command': 'blockdiag', 'exec': ['%c %s', 'i_view32 % {expand("%:p:r")}.png'], 'outputter': 'message' }
"let g:quickrun_config['rst'] = { 'command': 'sphinx-build', 'hook/sphinx/enable': 1, 'cmdopt': '-b html' }
let g:quickrun_config['rst'] = { 'command': 'make', 'cmdopt': 'html' }
let g:quickrun_config['cpp'] = { 'cmdopt': '-std=c++11 -Wall', 'hook/output_encode/enable': 1, 'hook/output_encode/encoding': 'cp932' }
let g:quickrun_config.make = { 'command': 'make', 'exec': '%c', 'hook/make_exec/enable': 1, 'hook/output_encode/enable': 1, 'hook/output_encode/encoding': 'cp932' }
let g:quickrun_config.make_only = { 'command': 'make', 'exec': '%c', 'hook/output_encode/enable': 1, 'hook/output_encode/encoding': 'cp932' }
let g:quickrun_config.exec_only = { 'command': expand('%:p:r'), 'exec': '%c', 'hook/output_encode/enable': 1 }
let g:quickrun_config.cpp_procon = { 'type': 'cpp', 'command': 'g++', 'cmdopt': '../gtest/gtest-all.cc ../gtest/gtest_main.cc' }
"let g:quickrun_config.c = { 'hook/output_encode/enable': 1, 'hook/output_encode/encoding': 'utf-8' }
let g:quickrun_config.cpp_make = { 'command': '', 'hook/exist_makefile/enable': 1, 'hook/output_encode/enable': 1, 'hook/output_encode/encoding': 'cp932' }
let g:quickrun_config.c_exe = { 'command': 'g++', 'exec': '%c %s', 'hook/output_encode/enable': 1, 'hook/output_encode/encoding': 'cp932' }
let g:quickrun_config.html = { 'command': 'cat', 'outputter': 'browser' }
nnoremap <silent> [quickrun]x :QuickRun cpp_procon<CR>
nnoremap <silent> [quickrun]m :QuickRun make_only<CR>
nnoremap <silent> [quickrun]mr :QuickRun cpp_make<CR>

"neocomplcache
"runtime! vimrcs/*.vim

" previm
let g:previm_open_cmd = ''
"let g:previm_disable_vimproc = 1
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
"nnoremap <silent> [unite]u :<c-u>Unite<Space>grep<CR>
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
"nnoremap <expr> gr ':Unite -auto-preview -tab grep:. -buffer-name=search-buffer<CR>(' . expand("<cword>") . ')'

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
set runtimepath+=~/.vim/after

" select all
"nnoremap <c-a> ggVG

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

" syntastic
"let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_chckers = ['rubocop']
let g:syntastic_markdown_chckers = ['textlint']
let g:syntastic_text_chckers = ['textlint']

"-------------------------------- neocomplcache --------------------------------
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"-------------------------------- neocomplcache --------------------------------

" fugitive
nnoremap [fugitive] <nop>
nmap <Space>g [fugitive]

" keymap
nnoremap <silent> [fugitive]b :Gblame -w<CR>
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
let g:vinarise_enable_auto_detect = 1
