" read vimrc_example
source $VIMRUNTIME/vimrc_example.vim

" edit vimrc
command! EV edit $MYVIMRC
command! RV source $MYVIMRC

" タブ幅の設定
set expandtab
set tabstop=4
set softtabstop=0
set shiftwidth=4

" ファイル名補完
set wildmode=list:longest

" マウスホイールでスクロール
set mouse=a
set ttymouse=xterm2
map <ScrollWheelUp> <C-Y>
map <S-ScrollWheelUp> <C-U>
map <ScrollWheelDown> <C-E>
map <S-ScrollWheelDown> <C-D>

" statuslineの表示
set laststatus=2

" comment
map fc <Plug>(func_comment)

" clipboard
"set clipboard+=unnamed

" no backup
set nobackup
set noswapfile

" ビープ音を消す
set visualbell t_vb=

" 行数表示
set number

" 検索ハイライト有効
set hlsearch

" インクリメンタルサーチ
set incsearch

" grでカーソル下のキーワードをvimgrep
nnoremap <expr> gr ':vimgrep ;\<' . expand('<cword>') . '\>; **/* \| cw'

nnoremap <c-h> <c-o>
nnoremap <c-l> <c-i>

" C-jをESCにマッピング
imap <c-j> <esc>

" vim diff color
hi DiffAdd      ctermfg=black ctermbg=2
hi DiffChange   ctermfg=black ctermbg=3
hi DiffDelete   ctermfg=black ctermbg=6
hi DiffText     ctermfg=black ctermbg=7

" tree view
let g:netrw_liststyle=3
let g:netrw_altv=1

" 水平分割で開く新しいファイルを下に開き、フォーカスを移す
"set splitbelow
"set splitright

" NeoBundle
set nocompatible
filetype off

if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" originalrepos on github
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
     \ 'mac' : 'make -f make_mac.mak',
    \ }
\ }
NeoBundle 'VimClojure'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'szw/vim-tags'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'vim-scripts/gtags.vim'
NeoBundle 'rking/ag.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle "tyru/current-func-info.vim"

" colorscheme
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'tomasr/molokai'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'altercation/vim-colors-solarized'

NeoBundle 'func-comment', {'type' : 'nosync', 'base' : '~/.vim/bundle'}
""NeoBundle 'https://bitbucket.org/kovisoft/slimv'

call neobundle#end()

filetype plugin indent on     " required!
filetype indent on
syntax on

NeoBundleCheck

" neocomplcache
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" colorscheme
colorscheme jellybeans 

" lightline
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

" quickrun
let g:quickrun_config = {}
let g:quickrun_config._ = {'runner' : 'vimproc', "runner/vimproc/updatetime" : 10}
