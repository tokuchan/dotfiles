#!/bin/bash
#. = Purpose
# Stow the packages that I consider to be essential to every system I touch.

#. == Programming languages first
stow python
stow rust

#. == Git next
stow git
stow git-config
stow git-annex

#. == Then editors
stow emacs
stow spacemacs
stow astro-nvim

#. == Shells and terminals next
stow bash
stow kitty
stow fish

#. == Finally utilitis
stow lazygit
stow zoxide
stow rclone
