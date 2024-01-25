function docker-clean-images --wraps='docker rmi (docker images -a --filter=dangling=true -q)' --description 'alias docker-clean-images=docker rmi (docker images -a --filter=dangling=true -q)'
  docker rmi (docker images -a --filter=dangling=true -q) $argv; 
end
