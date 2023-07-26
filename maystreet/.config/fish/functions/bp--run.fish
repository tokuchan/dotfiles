function bp--run --description 'Run command inside the specified container'
	command bp--run $argv
	#	argparse -is 'h/help' 'r/run-in-project-root' 'c/container=' -- $argv
	#	or return
	#	if test $_flag_help
	#		echo "Run a command inside the specified container.
	#		-c / --container            Specify the container used.
	#		-r / --run-in-project-root  Run the command in the same directory in which .git is found.
	#		-h / --help                 Display this help.
	#		"
	#	else
	#		set -l theMounts \
	#			-v $(readlink -f $HOME):$(readlink -f $HOME) \
	#			-v (pwd):(pwd)
	#
	#		if test $_flag_run_in_project_root
	#			podman run -ti --entrypoint bash $theMounts $_flag_container -c "cd "(git rev-parse --show-toplevel)" && $argv"
	#		else
	#			podman run -ti --entrypoint bash $theMounts $_flag_container -c "cd "(pwd)" && $argv"
	#		end
	#	end
end
