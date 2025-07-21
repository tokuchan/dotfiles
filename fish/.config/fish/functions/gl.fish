function gl --wraps='git log' --wraps=git\ log\ --all\ --graph\ --pretty=format:\'\%C\(magenta\)\%h\ \%C\(white\)\%an\ \%ar\%C\(auto\)\ \%D\%n\%s\%n\' --description alias\ gl=git\ log\ --all\ --graph\ --pretty=format:\'\%C\(magenta\)\%h\ \%C\(white\)\%an\ \%ar\%C\(auto\)\ \%D\%n\%s\%n\'
  git log --all --graph --pretty=format:'%C(magenta)%h %C(white)%an %ar%C(auto) %D%n%s%n' $argv
        
end
