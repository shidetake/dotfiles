echo .bashrc
if [ "$(uname)" == "Darwin" ]; then
    os=osx
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    os=linux
else
    os=windows
fi
echo $os

if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi

alias sjis2utf='iconv -f SHIFT_JIS -t UTF-8'
alias utf2sjis='iconv -f UTF-8 -t SHIFT_JIS'
alias gtagsc='gtags --gtagslabel=ctags'
alias gtagspy='gtags --gtagslabel=pygments'
alias ic='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"'
alias gitls='git ls-files -t | perl -pe "s/\/.*/\//" | sort | uniq -c'
alias pt='pt --vcs-ignore ~/.ptignore'

if [ $os == "osx" ]; then
    alias gvim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/MacVim "$@"'
    alias ctags='/usr/local/Cellar/ctags/5.8/bin/ctags'
#    alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
    alias lsusb='system_profiler SPUSBDataType'

    export EDITOR=/usr/local/bin/vim
    export GOPATH=$HOME/.go
    export PATH=$PATH:$GOPATH/bin

    export PATH=/usr/local/bin:$PATH
    export PATH=$HOME/.rbenv/bin:$PATH
    export PATH=$HOME/bin:$PATH
    export PATH=$HOME/bin/ghdl/bin:$PATH
    export PATH=/Applications/MakeMKV.app/Contents/MacOS:$PATH
    export PATH=/Applications/calibre.app/Contents/MacOS:$PATH

    export CLICOLOR=1
    export LSCOLORS=DxGxcxdxCxegedabagacad

    export RAILS_DATABASE_USER=root
    export RAILS_DATABASE_PASSWORD=

    # git completion
    source ~/.git-prompt.sh
    source ~/.git-completion.bash
    GIT_PS1_SHOWDIRTYSTATE=true
    export PS1='\u@\h:\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '
elif [ $os == "windows" ]; then
    export LANG=ja_JP.UTF-8

    alias ls='ls --show-control-chars --color'
    alias open='start'
    alias nvim='nvim-qt --maximized --no-ext-tabline'
    alias gvim=nvim
    alias tree='tree.com'
    alias c='pygmentize -O style=monokai -f console256 -g'
    alias uru='uru.bat'

    function share_history {
      history -a
      history -c
      history -r
    }
    PROMPT_COMMAND='share_history'
    shopt -u histappend
    export HISTSIZE=9999

    chcp.com 932
fi

if which pyenv > /dev/null 2>&1; then
    export PYENV_ROOT="${HOME}/.pyenv"
    export PATH=${PYENV_ROOT}/shims:${PATH}
    eval "$(pyenv init -)";
fi

if which rbenv > /dev/null 2>&1; then
    eval "$(rbenv init -)"
fi
