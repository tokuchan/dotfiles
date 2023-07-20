# Defined in /tmp/fish.ZdqXuI/tmosh.fish @ line 2
function tmosh --wraps='mosh $argv -- tmux a' --description 'alias tmosh=mosh $argv -- tmux a'
	mosh --no-init $argv -- tmux new-session -ADs main ;
end
