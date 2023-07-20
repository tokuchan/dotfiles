function count-lines --description 'Count lines matching a given pattern.'
    argparse -n'count-lines' 'k/key=' 's/show-key' 'h/help' -- $argv
    or return

    if test -n "$_flag_help"
        echo 'Usage: <input> | count-lines [options]
        -h, --help
        Show this help.
        -k, --key
        Specify the pattern to match against. (Required)
        -s, --show-key
        Show the key in the output.
        '
        return
    end

    if test -z "$_flag_key"
        echo "Must specify --key"
        return
    else
        set key "$_flag_key"
    end

    if test -n "$_flag_show_key"
        pee 'echo -n "$key: ... " >2 ; grep "$key" | wc -l >2' 'sponge'
    else
        pee 'echo "$key"'
    end
end
