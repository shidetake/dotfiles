echo .bash_profile
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.rbenv/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/bin/ghdl/bin:$PATH
export PATH=/Applications/MakeMKV.app/Contents/MacOS:$PATH
export PATH=/Applications/calibre.app/Contents/MacOS:$PATH

export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export RAILS_DATABASE_USER=root
export RAILS_DATABASE_PASSWORD=

source ~/.bashrc
