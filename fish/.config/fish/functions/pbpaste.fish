function pbpaste --description 'Pipe the clipboard, either OS or Linux, to stdout.'
if string match Linux (uname -s) > /dev/null
xclip -out
else
command pbpaste
end
end
