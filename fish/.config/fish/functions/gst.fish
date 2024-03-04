function gst --wraps='g st' --description 'alias gst=g st'
  echo
  echo Status
  echo ======
  echo
  echo Smartlog:
  g sl 'stack()'
  echo
  echo Changes:
  echo
  g changes --color=always | head -15;
  echo
  if git branch | grep patches
  then
    echo Patches:
    echo
    g patches --color=always | head -15;
    echo -e'\033]0m'
  end
  echo Status
  g st $argv; 
end
