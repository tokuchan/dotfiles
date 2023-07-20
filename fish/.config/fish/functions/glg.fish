function glg --wraps='echo bar' --wraps='git lg' --description 'alias glg=git lg'
  git lg $argv
end
