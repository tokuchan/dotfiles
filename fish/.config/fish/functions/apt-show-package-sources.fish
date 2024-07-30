function apt-show-package-sources --description 'Show a table of packages and their source URL and ppa names'
    set -q argv[1] || set argv -i ''
    apt-cache policy (dpkg -l | awk 'NR >= 6 {print $2}') | awk '\
       /^[^ ]/ {split($1, a, ":"); pkg=a[1]}; \
       nextline==1 {nextline=0; printf("%s %s %s\n", pkg, $2, $3)}; \
       /\*\*\*/ {nextline=1}' | grep $argv | mlr -i nidx -o pprint label PACKAGE-NAME,PACKAGE-URL,PACKAGE-SOURCE
end
