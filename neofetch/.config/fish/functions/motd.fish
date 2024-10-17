function motd --description 'print a nice motd'
$HOME/.local/bin/neofetch --ascii "(fortune | cowsay -W 30 -f dragon)" | lolcat
end
