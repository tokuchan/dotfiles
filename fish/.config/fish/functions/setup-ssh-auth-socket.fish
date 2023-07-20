function setup-ssh-auth-socket
set -e SSH_AGENT_PID
if not set -q gnupg_SSH_AUTH_SOCK_by or test $gnupg_SSH_AUTH_SOCK_by -ne $fish_pid
set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
end
end
