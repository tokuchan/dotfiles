function proxy--start --description 'Start Maystreet Proxy'
pushd ~/.local/share/proxy
sudo pkill -f http.server
sudo bash -c 'nohup python3 -m http.server 80& disown'
popd
end
