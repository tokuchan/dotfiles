function pdf--encrypt --description 'AES256-encrypt the specified PDF with a key generated from its hash.'
argparse -n'pdf--encrypt' 'k/key=' 'i/input=' 'o/output=' 'p/key-to-pasteboard' 'r/readable-key' 'h/help' -- $argv
or return
if test -n "$_flag_help"
echo 'Usage: pdf--encrypt [options]
-p, --key-to-pasteboard
             Send the key to the pasteboard. Otherwise, print it to the console.
-r, --readable-key
             Make the key output more readable by breaking it into groups of three.
             (Note the actual key does not have spaces in it.)
-k, --key    Specify a key to encrypt with. [Default: use the sha256 sum of the file.]
-i, --input  Specify the file to encrypt.
-o, --output Specify the encrypted file path. [Default: encrypted--<input>]
'
return
end

if test -n "$_flag_input"
set input "$_flag_input"
else
echo 'Must specify --input.'
return
end

if test -n "$_flag_output"
set output "$_flag_output"
else
set output (dirname $input)"/encrypted--"(basename $input)
end

if test -n "$_flag_key"
set key "$_flag_key"
else
set key (pdf--gen-key "$input")
end

if test -n "$_flag_readable_key"
echo -n "Key: ...... "
echo "$key" | chunk-text
else
echo "(Key sent to pasteboard)"
echo "$key" | pbcopy
end
echo "Input: .... $input"
echo "Output: ... $output"
rm "$output"
pdf--encrypt-file -k "$key" -i "$input" -o "$output"
end
