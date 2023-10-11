function glw --wraps='git log --oneline local-master...' --description 'alias glw=git log --oneline local-master...'
  git log --oneline local-master... $argv; 
end
