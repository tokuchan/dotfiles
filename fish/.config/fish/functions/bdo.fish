function bdo --description 'Run command inside the canonical cmake build-debug directory'
pushd (git rev-parse --show-toplevel)/build-debug
$argv
popd
end
