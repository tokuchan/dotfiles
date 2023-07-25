function bp--test --no-scope-shadowing
    set -l options (fish_opt --short=f --long=function --required-val)
    argparse $options -- $argv
    or return
    bp--with-context mkdir -p .bp--functions.d
    if set -q _flag_function
        banner--banner "Run $_flag_function"
        bp--with-context ./.bp--functions.d/$_flag_function
    else
        echo "No function named $_flag_function in " (pwd) "./.bp--function.d"
    end
end
