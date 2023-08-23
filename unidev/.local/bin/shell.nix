{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/d0f2758381caca8b4fb4a6cac61721cc9de06bd9.tar.gz") {}
, cwd ? /home/seans
}:

pkgs.mkShell {
  packages = [
    pkgs.asciidoctor-with-extensions
    pkgs.autojump
    pkgs.bat
    pkgs.black
    pkgs.ccls
    pkgs.doxygen_gui
    pkgs.duckdb
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
    pkgs.nodejs_20
    pkgs.oath-toolkit
    #pkgs.pass
    #pkgs.passExtensions.otp
    pkgs.parallel
    #pkgs.python311Packages.click
    #pkgs.python311Packages.ipython
    #pkgs.python311Packages.rich
    #pkgs.python311Packages.sh
    pkgs.qpdf
    pkgs.racket
    pkgs.rich-cli
    pkgs.ripgrep
    pkgs.semgrep
    pkgs.sqlite
    pkgs.sshfs
    pkgs.stow
    #pkgs.texlive.combined.scheme-full
    pkgs.xclip
    pkgs.zbar
  ];

  shellHook = ''
    export SHELL_TYPE="$SHELL_TYPE Unidev "
    cd ${cwd} && exec fish
  '';

  EDITOR = "nvim";
  LOCALE_ARCHIVE = "/usr/lib/locale/locale-archive";
}
