if [ "$(uname)" == "Darwin" ]; then
    os=osx
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    os=linux
fi
#echo $os

if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi

# git completion
source ~/.git-prompt.sh
source ~/.git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\u@\h:\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '

alias sjis2utf='iconv -f SHIFT_JIS -t UTF-8'
alias utf2sjis='iconv -f UTF-8 -t SHIFT_JIS'
alias gvim=vim

if [ $os == "osx" ]; then
    alias ctags='/usr/local/Cellar/ctags/5.8/bin/ctags'
    alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'

    export EDITOR=/usr/local/bin/vim
    export GOPATH=$HOME/.go
    export PATH=$PATH:$GOPATH/bin
fi
