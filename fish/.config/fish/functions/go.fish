function go --description 'Invoke ranger to go to a directory or launch a file'
ranger --choosedir=$HOME/.ranger-target $argv
cd (cat $HOME/.ranger-target)
end
