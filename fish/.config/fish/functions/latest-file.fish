function latest-file
echo (readlink --canonicalize $argv)/(ls -tl $argv | sed -n 2p | awk '{print $9}')
end
