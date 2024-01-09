function g --wraps=git --description 'alias g=git'
  if count $argv > /dev/null
    git $argv; 
  else
    gst
  end
end
