# Basic aliases
alias m='make -k -j20'
alias e='vim '
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git aliases
alias g='f() { if (( $# > 0 )); then git $@; else lazygit; fi; }; f'
alias lg='lazygit'
alias gg='git-goto'
alias gf='git-fuzzy-fetch'
alias gm='git merge'
alias ga='git-fuzzy-add'
alias gd='git diff'
alias gst='git status'
alias gc='git commit'

# Aliases for exa-overridden commands
if [ -n "$(which batcat 2> /dev/null)" ]
then
	alias bat=batcat
	alias cat=batcat
	alias less=batcat
fi

# Aliases for ripgrep
if [ -n "$(which rg 2> /dev/null)" ]
then
	alias rgf='rg --files | rg'
fi

# Fix ll in some places
alias l='command l'
alias ll='command ll'
