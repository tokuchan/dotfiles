function bp--change-id --description 'Generate a random Change ID for Gerrit'
dd status=none if=/dev/urandom bs=64 count=1 | sha1sum -b | awk '{print "Change-Id: I"$1}'
end
