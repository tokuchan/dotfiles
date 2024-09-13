#!/usr/bin/fish

#
# Set required environment variables
#
set -Ux PETALINUX {$HOME}/.local/share/PetaLinux
set -Ux PETALINUX_VER 2023.1
set -Ux PETALINUX_MAJOR_VER 2023
set -Ux XSCT_TOOLCHAIN {$PETALINUX}/tools/xsct

#
# Add toolchains to user's search path
#
fish_add_path {$XSCT_TOOLCHAIN}/gnu/aarch32/lin/gcc-arm-none-eabi/bin
fish_add_path {$XSCT_TOOLCHAIN}/gnu/aarch32/lin/gcc-arm-linux-gnueabi/bin
fish_add_path {$XSCT_TOOLCHAIN}/gnu/aarch64/lin/aarch64-none/bin
fish_add_path {$XSCT_TOOLCHAIN}/gnu/aarch64/lin/aarch64-linux/bin
fish_add_path {$XSCT_TOOLCHAIN}/gnu/armr5/lin/gcc-arm-none-eabi/bin
fish_add_path {$XSCT_TOOLCHAIN}/gnu/microblaze/lin/bin

#
# Add required binary tools to the user's search path
#
fish_add_path {$PETALINUX}/tools/common/petalinux/bin
fish_add_path {$PETALINUX}/tools/xsct/petalinux/bin

{$PETALINUX}/tools/common/petalinux/utils/petalinux-env-check
