function ls --wraps=exa --description 'alias ls=exa'
  if which exa > /dev/null
    exa --icons $argv; 
  else
    command ls $argv
  end
end
