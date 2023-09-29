# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
if ! [[ "$PATH" =~ "$HOME/dotfiles/bash/.local/bin:" ]]
then
	PATH="$HOME/dotfiles/bash/.local/bin:$PATH"
fi
if ! [[ "$PATH" =~ "/data/archive/mst_tools/latest/" ]]
then
    PATH="$PATH:/data/archive/mst_tools/latest/"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias cm='cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_FLAGS="-std=c++17 -fPIC" '
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
alias ga='git add -e'
alias gd='git diff'
alias gst='git status'
alias gc='git commit'

# If installed alias exa and bat to augment pager and ls
if [ -n "$(which exa 2> /dev/null)" ]
then
	alias ls='exa'
	alias ll='exa -lbah --icons --colour-scale'
else
	alias ll='ls -lasFhvx1 --full-time --group-directories-first --hyperlink=always --color=always'
fi

if [ -n "$(which batcat 2> /dev/null)" ]
then
	alias bat=batcat
	alias cat=batcat
	alias less=batcat
fi

# Gracefully handle exiting from tmux
exit() {
	if [[ -z $TMUX ]]; then
		builtin exit
		return
	fi

	panes=$(tmux list-panes | wc -l)
	wins=$(tmux list-windows | wc -l) 
	count=$(($panes + $wins - 1))
	if [ $count -eq 1 ]; then
		tmux detach
	else
		builtin exit
	fi
}

# Define a handy history-search tool
histgrep() {
	history | grep -v histgrep | grep "$*" | tail -n10
}

#export TERM="eterm-color"
export TERM=vt220

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Set up a nice prompt
source ~/.local/bin/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\w$(__git_ps1 " (%s)") λ '
