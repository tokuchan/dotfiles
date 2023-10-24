# Basic aliases
alias m='make -k -j20'
alias e='vim '
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git aliases
alias g='git '
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
