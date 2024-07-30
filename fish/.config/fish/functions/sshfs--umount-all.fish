function sshfs--umount-all --description 'Try to unmount everything in ~/mnt/'
  for path in (find ~/mnt/ -maxdepth 1 -print | tail +2 | fzf -m)
    if test -d "~/mnt/$path"
      printf "Skipping: %s\n" $path
      continue
    else
      printf "Trying to unmount: %s\n" $path
      sshfs--umount $path
    end
  end
end
