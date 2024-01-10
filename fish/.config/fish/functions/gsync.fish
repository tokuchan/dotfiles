function gsync --wraps='git switch master && git pull gerrit master --ff && git submodule sync && git submodule init && git submodule update && git switch patches && git rebase' --wraps='git switch master && git pull gerrit master --ff && git submodule sync && git submodule init && git submodule update && git switch patches && git rebase && git switch local-master && git merge --no-ff master' --description 'alias gsync=git switch master && git pull gerrit master --ff && git submodule sync && git submodule init && git submodule update && git switch patches && git rebase && git switch local-master && git merge --no-ff master'
  git switch master && git pull gerrit master --ff && git submodule sync && git submodule init && git submodule update && git switch patches && git rebase && git switch local-master && git merge --no-ff master $argv; 
end
