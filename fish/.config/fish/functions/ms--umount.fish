function ms--umount --description 'unmount the SSHFS filesystem'
fusermount3 -u $argv
end
