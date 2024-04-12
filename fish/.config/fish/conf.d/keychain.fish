if status is-login
  and status is-interactive
  # To add a key, set -Ua SSH_KEYS_TO_AUTOLOAD path/to/key
  # To remove a key, set -U --erase SSH_KEYS_TO_AUTOLOAD[index-of-key]
  keychain --eval $SSH_KEYS_TO_AUTOLOAD | source
end
