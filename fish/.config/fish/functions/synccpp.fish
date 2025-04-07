function synccpp --description 'Sync C++ source files between a src and dest directory.'
rcp -c --include='*.cpp' --include='*.hpp' --include='*.c' --include='*.C' --include='*.h' --include='*.H' --include='Makefile' --include='CMakeLists.txt' --exclude='.git' --include='*/' --exclude='*' $argv
end
