function ll --wraps='ls -lba' --wraps='ls -lba #' --wraps='ls -lba ' --description 'alias ll=ls -lba '
  ls -lbah --icons --colour-scale $argv
        
end
