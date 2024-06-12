function motd --description 'print a nice motd'
neofetch --ascii "$(fortune | cowsay -W 30 -f dragon)" | lolcat
end
