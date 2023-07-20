function glsql --description 'Run glcsv and open a SQLite3 DB console on the result'
 textql -header -console (glcsv $argv | psub)
end
