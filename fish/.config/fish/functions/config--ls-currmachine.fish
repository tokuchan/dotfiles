function config-ls-currmachine
printf 'Current architecture: %s\n' (uname -m)
config-pushd-currarch 
ls $argv
popd
printf '\nCurrent OS type: %s\n' (uname -s)
config-pushd-curros
ls $argv
popd
printf '\nCurrent hardware name: %s\n' (uname -n)
config-pushd-currmachine
ls $argv
popd
end
