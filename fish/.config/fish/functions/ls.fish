function ls --wraps=exa --description 'alias ls=exa'
  if which exa > /dev/null
    exa $argv; 
  else
    command ls $argv
  end
end
