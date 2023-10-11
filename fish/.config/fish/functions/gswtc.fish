function gswtc --wraps='git switch --track=direct -c ' --description 'alias gswtc=git switch --track=direct -c '
  if printf '%s\n' (git --version | awk '{print $3}') '2.35.0' | sort -C -V
    git switch --track -c  $argv
  else
    git switch --track=direct -c  $argv
  end    
end
