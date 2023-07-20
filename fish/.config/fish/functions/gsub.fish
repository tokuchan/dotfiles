function gsub --wraps='git submodule' --description 'alias gsub=git submodule'
  git submodule $argv; 
end
