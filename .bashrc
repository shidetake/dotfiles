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
