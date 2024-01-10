function gsub --wraps='git submodule' --description 'alias gsub=git submodule'
  if count $argv > /dev/null
    git submodule $argv; 
  else
    git submodule sync && git submodule init && git submodule update 
  end

end
