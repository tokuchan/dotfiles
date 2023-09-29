# Set up a nice prompt
source ~/.local/bin/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\w$(__git_ps1 " (%s)") λ '
