function bp-cmake-clang
cd $HHOME/dev/bellport/build-debug \
&& set -x CXX /usr/bin/clang++-14 \
&& cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_FLAGS="-std=c++20 -fPIC" -DCMAKE_CXX_COMPILER_LAUNCHER=ccache -DBELLPORT_LICENSE_ENABLED=OFF ../
end
