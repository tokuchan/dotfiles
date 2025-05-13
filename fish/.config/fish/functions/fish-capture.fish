function fish-capture
    # directories
    set -l functionsDir     ~/.config/fish/functions
    set -l dotfilesFunctionsDir ~/dotfiles/fish/.config/fish/functions

    # no args → help
    if test (count $argv) -eq 0
        echo "Usage:"
        echo "  fish-capture --list"
        echo "  fish-capture <function_name>"
        return 1
    end

    # --list: show all uncaptured functions
    if test $argv[1] = '--list'
        for file in $functionsDir/*.fish
            if not test -L $file
                echo (basename $file .fish)
            end
        end
        return
    end

    # capture a named function
    set -l functionName $argv[1]
    set -l sourceFile    $functionsDir/$functionName.fish

    # sanity checks
    if not test -e $sourceFile
        echo "Error: function '$functionName' not found in $functionsDir"
        return 1
    end

    if test -L $sourceFile
        echo "Warning: '$functionName.fish' is already a symlink; aborting"
        return 1
    end

    # move into dotfiles and restow
    mkdir -p $dotfilesFunctionsDir
    mv $sourceFile $dotfilesFunctionsDir/

    pushd ~/dotfiles >/dev/null
    stow fish
    popd >/dev/null
end

