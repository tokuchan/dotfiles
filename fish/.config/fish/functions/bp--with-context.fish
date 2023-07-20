function bp--with-context --description 'Run a command from within the Bellport build directory.'
argparse -is --name "bp--with-context" "n/no-echo" -- $argv
or return
if test -z "$_flag_no_echo"
echo "$argv" 1>&2
end
pushd $HHOME/dev/bellport/build-debug \
&& $argv \
&& popd
end
