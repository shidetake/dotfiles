alias sjis2utf='iconv -f SHIFT_JIS -t UTF-8'
alias utf2sjis='iconv -f UTF-8 -t SHIFT_JIS'
alias gtagsc='gtags --gtagslabel=ctags'
alias gtagspy='gtags --gtagslabel=pygments'
alias ic='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"'
alias gitls='git ls-files -t | perl -pe "s/\/.*/\//" | sort | uniq -c'
alias pt='pt --vcs-ignore ~/.ptignore'
alias sshls='cat ~/.ssh/config | grep ^Host | awk "{print \$2}"'