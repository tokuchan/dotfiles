{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/d0f2758381caca8b4fb4a6cac61721cc9de06bd9.tar.gz") {}
, cwd ? /home/seans
}:

pkgs.mkShell {
  packages = [
    pkgs.autojump
    pkgs.asciidoctor-with-extensions
    pkgs.bat
    pkgs.emacs29
    pkgs.exa
    pkgs.figlet
    pkgs.fish
    pkgs.fzf
    pkgs.gitFull
    pkgs.gnumake
    pkgs.jq
    pkgs.keychain
    pkgs.meld
    pkgs.neovim
    pkgs.qpdf
    pkgs.ripgrep
    pkgs.sqlite
    pkgs.sshfs
    pkgs.stow
    pkgs.xclip
  ];

  shellHook = ''
    export SHELL_TYPE="$SHELL_TYPE Unidev "
    exec fish -c "cd ${cwd}"
  '';

  EDITOR = "nvim";
  LOCALE_ARCHIVE = "/usr/lib/locale/locale-archive";
}
