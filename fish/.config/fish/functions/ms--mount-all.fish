function ms--mount-all --description 'Try to mount everything in ~/mnt/'
  for path in (find ~/mnt/ -maxdepth 1 -print | tail +2 | fzf -m)
    if test -d "~/mnt/$path" 
      printf "Skipping: %s\n" $path
      continue
    else
      printf "Trying to mount: %s\n" $path
      ms--mount $path
    end
  end
end
