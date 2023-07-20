function gpr --description 'Run git pull-rebase to sync patches and master'
git pull-master \
&& git rebase-patches
git status
end
