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
alias g='git '
alias e='vim '
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

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
