function bp--cmake --description 'Build Bellport CMake cache and Makefile'
bp--with-context cmake \
-DCMAKE_CXX_FLAGS='-std=c++20 -fPIC -Wall -Wextra' \
# -fsanitize=address -fsanitize=undefined \
#-DCMAKE_EXE_LINKER_FLAGS='-fsanitize=address' \
#-DCMAKE_MODULE_LINKER_FLAGS='-fsanitize=address' \
-GNinja \-DCMAKE_BUILD_TYPE=Debug \
-DBELLPORT_FORCE_DISABLE_REUSEPORT=On \
-DBELLPORT_TEST_MODE_QUICK=On -DUSE_NAPATECH=On \
-DBELLPORT_USE_OMD=On \
-DBELLPORT_USE_KX=On \
-DBELLPORT_LICENSE_ENABLED=Off -DBELLPORT_OPENONLOAD_VERSION=onload-7.1.2.141 \
-DBELLPORT_APPEND_VC_REV=Off \
-DBELLPORT_NO_VERSION_NUMBER=On \
../
end
