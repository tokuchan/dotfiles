function glcsv --wraps='git log' --description 'Render git log as a CSV, with column headers'
echo '"id","hash","side","subject","author-name","author-email","date","refs"'
glg --pretty='"%H","%m","%s","%aN","%aE","%ad","%d"' $argv | awk '{printf "%d,%s\n", NR, $0}'
end
