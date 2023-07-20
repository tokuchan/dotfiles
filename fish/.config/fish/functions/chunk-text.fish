function chunk-text --description 'Break the input into groups of --length character blocks.'
argparse -n'chunk-text' 'l/length=' 'h/help' -- $argv
or return
if test -n "$_flag_help"
echo 'Usage: chunk-text [options]
-l, --length  Specify the number of characters in each block to show. [Default: 3]
'
end

if test -z "$_flag_length"
set length 3
else
set length "$_flag_length"
end
sed -r 's/(.{'$length'})/\1 /g'
end
