function bp--build --description 'Run build process for specified target.'
argparse 't/target=' -- $argv
or return
bp--with-context cmake --build . -j6 -- "$_flag_target"
end
