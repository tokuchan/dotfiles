function set-display
set -Ux DISPLAY (cat /etc/resolv.conf | grep nameserver | awk '{print $2}';):0
end
