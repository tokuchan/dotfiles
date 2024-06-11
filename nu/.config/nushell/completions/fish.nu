#def fish_completer [] {|spans|
#  fish --command $'complete "--do-complete=($spans | str join " ")"'
#  | $"value(char tab)description(char newline)" + $in
#  | from tsv --flexible --no-infer
#}
#
#export extern main []
