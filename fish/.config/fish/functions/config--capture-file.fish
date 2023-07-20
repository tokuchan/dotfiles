function config-capture-file
mv $argv (config-pwd-currmachine)
ln -s (config-pwd-currmachine)/$argv $argv
end
