function bp--crow--build
pushd $HHOME/dev/bellport/build-debug \
&& make -j6 crow \
&& popd
end
