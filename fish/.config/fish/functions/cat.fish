function cat --wraps=bat --description 'alias cat=bat'
  if which bat >/dev/null 2>/dev/null
    bat $argv; 
  else
    cat $argv;
  end
end
