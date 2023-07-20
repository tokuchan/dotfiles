function pbcopy --description 'Pipe input to the clipboard, either OS or Linux'
if string match Linux (uname -s) > /dev/null
xclip
else
command pbcopy
end
end
