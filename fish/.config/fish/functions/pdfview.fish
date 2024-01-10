function pdfview --wraps='pandoc -t pdf -o /tmp/pdfview/(string split -m1 -f1 . $argv[0] | string split -m1 -r -f2 /).pdf $argv[0] && l'
  set -l path_in (readlink -e $argv[1])
  set -l path_out /tmp/(basename $path_in | sed 's,\..*$,,')-(random).pdf
  pandoc -t pdf $path_in -o $path_out && l $path_out 
end
