function totp --description 'Generate a TOTP passphrase and send it to xclip'
set -l name (pass totp 2>/dev/null | jq -r '.[] | "\(.issuer): \(.name)"' | fzf | sed 's,^.*: ,,')
pass totp 2>/dev/null | jq -r ".[] | select(.name | contains("'"'"$name"'"'")).totpSecret" | oathtool -b --totp - | xclip -f
#pass otp -c $name
#pass totp 2>/dev/null | jq -r '.[] | select(.name | contains("'(pass totp 2>/dev/null | jq -r '.[] | "\(.issuer): \(.name)"' | fzf)'")).totpSecret'
end
