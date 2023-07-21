function ee --wraps='disown emacs&' --wraps='emacs $argv&; disown' --description 'alias ee=emacs $argv&; disown'
  emacs $argv&; disown
end
