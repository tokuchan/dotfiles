function gg --wraps='git gui' --wraps='git gui&' --wraps='git gui $argv&' --description 'alias gg=git gui $argv&'
  git gui $argv& $argv
        
end
