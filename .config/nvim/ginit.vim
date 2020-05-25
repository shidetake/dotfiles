echomsg '.gvimrc'

" colorscheme
syntax on

nnoremap <c-c><c-m> :call Color_molokai()<CR>
function! Color_molokai()
  colorscheme molokai
  let g:molokai_original = 1
  let g:rehash256 = 1
  set background=dark
  set guioptions=egrLt
endfunction

nnoremap <c-c><c-l> :call Color_louver()<CR>
function! Color_louver()
  colorscheme louver
  set background=light
endfunction

call Color_molokai()

" TOhtml with light color
function! TOhtmlEx()
  call Color_louver()
  :TOhtml
  :QuickRun html
  call Color_molokai()
endfunction
command! TOhtmlEx :call TOhtmlEx()

" font
if has('nvim')
  Guifont! Myrica\ M:h12
else
  set guifont=Myrica\ M:h12
endif

if has('nvim')
  "call GuiWindowMaximized(1)
else
  au GUIEnter * simalt ~x
endif

if has('nvim')
  if @% == ""
    bd
  endif
endif

