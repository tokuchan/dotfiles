function ms--mount-all --description 'Try to mount everything in ~/mnt/'
for path in ~/mnt/*
test -d $path || continue
echo $path
ms--mount $path
end
end
