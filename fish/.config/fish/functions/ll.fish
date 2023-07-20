function ll --wraps='la -alhT --level=2' --wraps='la -lhT --level=2' --wraps='la -alhT' --wraps='la -alh' --description 'alias ll=la -alh'
  la -alh $argv; 
end
