function vpn--start
  echo -e "\rIs OpenVPN currently running?"
  if pgrep -fa openvpn
    echo \e "\rYes, so I will kill it now."
    sudo pkill -9 -f openvpn
  else
    echo \e "\rNo."
  end

  echo -e "\rStarting OpenVPN in daemon mode"
  sudo openvpn --config ~/.local/share/openvpn/maystreet.ovpn --daemon
  pgrep -fa openvpn

  echo -e "\rSetting up DNS resolution"
  for i in seq 10 -1 0
    if sudo resolvectl dns tun0 10.98.16.41 10.98.16.42 2> /dev/null
        break
    end
    echo -n .
    sleep 2
  end
  echo -e '\rDone'
end
