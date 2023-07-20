function pdf--gen-key --description 'Generate an encryption key from a file hash.'
openssl sha256 -hex $argv | cut -d' ' -f2 | cut -c 34-
end
