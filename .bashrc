echo .bashrc
if [ -f ~/.bashrc.os ]; then
    source ~/.bashrc.os
fi

if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

if [ -f ~/.bash_aliases.os ]; then
    source ~/.bash_aliases.os
fi

if which pyenv > /dev/null 2>&1; then
    export PYENV_ROOT="${HOME}/.pyenv"
    export PATH=${PYENV_ROOT}/shims:${PATH}
    eval "$(pyenv init -)";
fi

if which rbenv > /dev/null 2>&1; then
    eval "$(rbenv init -)"
fi
