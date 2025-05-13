function until --description 'Run a command until it succeeds'
    if test (count $argv) -eq 0
        echo "Usage: until <command>"
        return 1
    end

    while true
        $argv
        if test $status -eq 0
            break
        end
        echo "Command failed, retrying... (Press Ctrl-C to cancel)"
        sleep 1
    end
end
