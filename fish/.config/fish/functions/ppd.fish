function ppd --wraps='parallel -Ssspillane@dev-nyc3-sv002.corp.maystreet.com --sshdelay 0.1' --description 'alias ppd=parallel -Ssspillane@dev-nyc3-sv002.corp.maystreet.com --sshdelay 0.1'
  parallel -Ssspillane@dev-nyc3-sv002.corp.maystreet.com --sshdelay 0.1 $argv
        
end
