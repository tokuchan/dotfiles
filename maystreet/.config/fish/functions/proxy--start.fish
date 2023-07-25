function proxy--start --description 'Start Maystreet Proxy'
pushd ./local/share/proxy
pkill -f http.server
nohup python3 -m http.server 80&
sleep 1
disown %1
popd
end
