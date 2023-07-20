function bp--build-test --description 'Build and test specified target.'
argparse 't/target=' 'f/function=' -- $argv
or return
echo \
&& banner--banner "Build $_flag_target" \
&& bp--build -t "$_flag_target" \
&& bp--build -t "$_flag_target"_test \
&& banner--banner "Test $_flag_target" \
&& bp--test -f "$_flag_function"

set exit_status $status

banner--box 'Search keys' \
&& echo ""\
    && banner--key "Build $_flag_target" \
&& banner--key "Test $_flag_target"

return $exit_status
end
