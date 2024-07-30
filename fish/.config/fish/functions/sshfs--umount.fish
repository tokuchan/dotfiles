function sshfs--umount --description 'Unmount the given sshfs path'
if test (uname) = "Linux"
fusermount3 -u $argv
else
umount $argv
end
end
