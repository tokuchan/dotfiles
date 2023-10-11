function gl1 --wraps='git log --oneline' --description 'alias gl1=git log --oneline'
  git log --oneline $argv; 
end
