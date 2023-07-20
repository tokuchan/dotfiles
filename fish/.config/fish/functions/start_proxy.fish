function start_proxy
pushd ~/.local/share/proxy-web
ps aux | grep http.server | grep -v grep | awk '{print $2}' | xargs kill
nohup python -m http.server 80&
popd
end
