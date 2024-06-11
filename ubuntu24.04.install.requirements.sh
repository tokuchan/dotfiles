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
clang-tidy-15

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
libgccjit-10-dev \
libgccjit-11-dev \
libgccjit-12-dev \
libgif-dev \
libpng-dev \
libpng++-dev \
libxpm-dev \
libbsd-dev \
libzip-dev

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
miller
