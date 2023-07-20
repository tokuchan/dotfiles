function pdf--encrypt-file --description 'Given a key and PDF, encrypt that PDF with AES256.'
argparse -n 'pdf--encrypt-file' 'k/key=' 'i/input=' 'o/output=' -- $argv
or return
if string match Linux (uname -s) > /dev/null
qpdf $_flag_input --encrypt $_flag_key $_flag_key 256 -- $_flag_output
else
echo 'Only Linux is supported. Try Unidev.'
return
end
end
