function docker-cleanable-ps --wraps='docker ps --filter=status=exited --filter=status=created -q' --wraps='docker ps --filter=status=exited --filter=status=created' --description 'alias docker-cleanable-ps=docker ps --filter=status=exited --filter=status=created'
  docker ps --filter=status=exited --filter=status=created $argv; 
end
