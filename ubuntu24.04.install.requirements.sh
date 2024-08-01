#!/bin/bash
# Install requirements for Ubuntu 22.04 LTS

# Add universe
yes | sudo add-apt-repository universe
sudo apt-get update

# Install base packages:
sudo apt install -yqq \
automake \
build-essential \
cmake \
gcc-12 \
gettext \
git \
gitk \
make \
ninja-build \
pkg-config \
clang-format-15 \
clang-tidy-15 \
ppa-purge

# Install mesa packages:
# Mesa is currently broken on distro, so we add a PPA with a point release for now:
#yes | sudo ppa-purge ppa:kisak/kisak-mesa
#yes | sudo add-apt-repository ppa:kisak/kisak-mesa > /dev/null
sudo apt install -yqq \
libgl1-mesa-dri \
mesa-utils

# Install libraries:
sudo apt install -yqq \
libcurl4-openssl-dev \
libfontconfig-dev \
libfreetype-dev \
libglib2.0-dev \
libgnutls28-dev \
libgtk-3-dev \
libncurses-dev \
libssl-dev \
libtool \
libvterm-dev \
libxml2-dev \
libgccjit-9-dev \
libgccjit-13-dev \
libgccjit-14-dev \
libgif-dev \
libpng-dev \
libpng++-dev \
libxpm-dev \
libbsd-dev \
libzip-dev \
libqrencode-dev \
libsqlite3-dev \
libreadline-dev \
libffi-dev \
libglib2.0-dev \
libpoppler-dev \
libpoppler-glib-dev \
libcairo2-dev \
libwxgtk3.2-dev

# Install utilities:
sudo apt install -yqq \
bat \
curl \
eza \
fish \
fzf \
git-flow \
kitty \
podman \
podman-docker \
stow \
unzip \
doxygen \
graphviz \
ripgrep \
devhelp \
cppreference-doc-en-html \
pass \
jq \
ranger \
keychain \
sshfs \
meld \
tcl-awthemes \
miller \
texinfo \
openssh-server \
fortune \
cowsay \
lolcat \
locate \
oathtool \
gdb \
imagemagick \
zbar-tools \
traceroute \
python3-pip \
zstd \
wslu \
valgrind \
git-gui \
perl-doc
