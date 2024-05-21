function current-ip --description 'get current host IP'
 ip route show | grep -i default | awk '{print $3}'
end
