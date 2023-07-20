= Setup for Maystreet OpenVPN
First, create a file in `~/.local/share/openvpn/auth.txt` with two lines. The first must be your username. The second must be your password.

Next, please note that the control scripts for the VPN are fish functions. Stow fish to set them up. Then, run `vpn--start` to connect and `vpn--stop` to disconnect.
