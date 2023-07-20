function ms--umount-all --description 'Try to unmount everything in ~/mnt/'
for path in ~/mnt/*
test -d $path || continue
echo $path
ms--umount $path
end
end
