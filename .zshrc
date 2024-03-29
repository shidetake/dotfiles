echo .zshrc
if [ "$(uname)" = "Darwin" ]; then
    os=osx
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
    os=linux
fi
#echo $os

if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

# git completion
source $(brew --prefix)/opt/zsh-git-prompt/zshrc.sh
git_prompt() {
  if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = true ]; then
    PROMPT='%F{034}%n%f %F{036}%f:%F{020}%~%f $(git_super_status)'
    PROMPT+=""$'\n'"%# "
  else
    PROMPT="%F{034}%n%f %F{036}%f:%F{020}%~%f "$'\n'"%# "
  fi
}

add_newline() {
  if [[ -z $PS1_NEWLINE_LOGIN ]]; then
    PS1_NEWLINE_LOGIN=true
  else
    printf '\n'
  fi
}

precmd() {
  git_prompt
  add_newline
}

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

alias sjis2utf='iconv -f SHIFT_JIS -t UTF-8'
alias utf2sjis='iconv -f UTF-8 -t SHIFT_JIS'
alias gvim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/MacVim "$@"'
alias gtagspy='gtags --gtagslabel=pygments'

export PATH=$PATH:/Applications/MakeMKV.app/Contents/MacOS
export PATH=$PATH:~/git/ripping

if [ $os = "osx" ]; then
    alias ctags='/usr/local/Cellar/ctags/5.8/bin/ctags'
#    alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
    alias lsusb='system_profiler SPUSBDataType'

    #export EDITOR=/usr/local/bin/vim
    export GOPATH=$HOME/.go
    export PATH=$PATH:$GOPATH/bin
fi

if which pyenv > /dev/null; then
    export PYENV_ROOT="${HOME}/.pyenv"
    export PATH=${PYENV_ROOT}/shims:${PATH}
    eval "$(pyenv init -)";
fi

if which rbenv > /dev/null; then
    eval "$(rbenv init -)"
fi
#export PATH="$(brew --prefix qt@5.5)/bin:$PATH"
. /opt/homebrew/opt/asdf/libexec/asdf.sh
export PATH="/opt/homebrew/opt/mozjpeg/bin:$PATH"
