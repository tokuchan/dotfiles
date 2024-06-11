function host-key --description 'Get SSHD host key for this host'
ssh-keyscan -p 2222 (uname -n) | ssh-keygen -lf -
end
