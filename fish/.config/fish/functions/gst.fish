function gst --wraps='g st' --description 'alias gst=g st'
  echo
  echo Status:
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
  echo
  g st $argv; 
end
