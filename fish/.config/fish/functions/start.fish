function start --description 'Start a GUI program from the shell.'
$argv 2>/dev/null 1>/dev/null& disown
end
