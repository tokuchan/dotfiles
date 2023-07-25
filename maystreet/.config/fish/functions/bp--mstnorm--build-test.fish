function bp--mstnorm--build-test
    echo \
        && banner--banner 'Build mstnorm' \
        && bp--mstnorm--build \
        && banner--banner 'Test mstnorm' \
        && bp--mstnorm--test $argv

    set exit_status $status

    banner--box 'Search keys' \
        && echo ""\
        && banner--key 'Build mstnorm' \
        && banner--key 'Test mstnorm' \
        && banner--key 'Run mstnorm_test' \
        && banner--key 'Run mstnorm'

    return $exit_status
end
