alias sjis2utf='iconv -f SHIFT_JIS -t UTF-8'
alias utf2sjis='iconv -f UTF-8 -t SHIFT_JIS'
alias ctags='/usr/local/Cellar/ctags/5.8/bin/ctags'
alias gvim=vim

export EDITOR=/usr/local/bin/vim
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

# git setting
source /usr/local/Cellar/git/2.0.1/etc/bash_completion.d/git-prompt.sh
source /usr/local/Cellar/git/2.0.1/etc/bash_completion.d/git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=true
#export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '
export PS1='\u@\h:\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '
