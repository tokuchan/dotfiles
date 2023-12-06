function vimwhich --wraps=vim --wraps='vim (which $args)' --wraps='vim (which $argv)' --description 'alias vimwhich=vim (which $argv)'
  vim (which $argv); # $argv; 
end
