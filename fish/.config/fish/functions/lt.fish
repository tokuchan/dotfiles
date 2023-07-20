function lt --wraps='ls -lhT --level=3' --description 'alias lt=ls -lhT --level=3'
  ls -lhT --level=3 $argv; 
end
