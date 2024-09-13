function start-emacs --description 'Start EMACS and disown it'
    emacs 2>/dev/null & && disown
end
