function apt-find --description 'Search apt database for a desired package'
    apt search $argv 2>/dev/null | awk 'NR >= 3 {print}' | awk '
/^[^ ]/ {pkg=$1; ver=$2; arch=$3};
/^[  ]/ && nextline=1 {nextline=0; printf("pkg %s\nver %s\narch %s\ndesc %s\n\n", pkg, ver, arch, $0)};
/^[ ]*$/ {nextline=1}' | mlr -i xtab -o pprint grep $argv
end
