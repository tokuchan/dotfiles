function gst --wraps='g st' --description 'alias gst=g st'
  echo
  echo Status:
  echo
  g st $argv; 
  echo
  echo Smartlog:
  g sl 'stack()'
  echo
  echo Changes:
  echo
  g changes;
  echo
  echo Patches:
  echo
  g patches;
end
