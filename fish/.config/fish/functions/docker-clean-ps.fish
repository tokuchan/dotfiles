function docker-clean-ps --wraps='docker rm (docker ps --filter=status=exited --filter=status=created -q)' --description 'alias docker-clean-ps=docker rm (docker ps --filter=status=exited --filter=status=created -q)'
  docker rm (docker ps --filter=status=exited --filter=status=created -q) $argv; 
end
