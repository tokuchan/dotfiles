function pafix --wraps='pactl set-default-sink (pactl list short sinks | cut -f2 | fzf)' --description 'alias pafix=pactl set-default-sink (pactl list short sinks | cut -f2 | fzf)'
  pactl set-default-source (pactl list short sources | cut -f2 | fzf --query='yeti' --border --prompt='Select source --> ')
  pactl set-default-sink (pactl list short sinks | cut -f2 | fzf --query='kt' --border --prompt='Select sink --> ') #$argv
end
