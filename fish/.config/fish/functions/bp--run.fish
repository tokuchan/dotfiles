function bp--run --description 'Run command inside the specified container'
argparse -is 'h/help' 'c/container=' -- $argv
or return
if test $_flag_help
echo "Run a command inside the specified container.
-c / --container  Specify the container used.
-h / --help  Display this help.
"
else
podman run -ti --entrypoint bash -v /home/seans/dev/bellport-stow:/home/seans/dev/bellport-stow -v (pwd):(pwd) $_flag_container -c "cd "(pwd)" && $argv"
end
end
