function exit
  if test -z $TMUX
    builtin exit
    return
  end
  set -l panes (tmux list-panes | wc -l)
  set -l wins (tmux list-windows | wc -l)
  set -l count (math $panes + $wins - 1)
  if test $count -eq 1
    tmux detach
  else
    builtin exit
  end
end
