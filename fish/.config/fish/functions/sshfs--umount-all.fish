function sshfs--umount-all --description 'Try to unmount everything in ~/mnt/'
for path in ~/mnt/*
test -d $path || continue
echo $path
sshfs--umount $path
end
end
