function docker-cleanable-images --wraps='docker images -a --filter=dangling=true -q' --wraps='docker images -a --filter=dangling=true' --description 'alias docker-cleanable-images=docker images -a --filter=dangling=true'
  docker images -a --filter=dangling=true $argv; 
end
