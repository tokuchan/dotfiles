function banner--hr
argparse --name=banner--box 't/text=' 'd/delimiter=' -- $argv
or return

if test -z $_flag_text
echo "Must pass --text option"
return
else
set text $_flag_text
end

if test -z $_flag_delimiter
set delimiter "="
else
set delimiter $_flag_delimiter
end

perl -e "print('$delimiter' x "(figlet -t $text | wc -L)')'
echo
end
