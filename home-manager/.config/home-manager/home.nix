{ config, pkgs, lib, ... }:

let
  # --- Your personal repos (edit these) ---
  myDotfiles = builtins.fetchGit {
    # e.g. "git@github.com:you/spacemacs.d.git" or "https://github.com/you/spacemacs.d.git"
    url = "git@github.com:tokuchan/dotfiles.git";
    # Optionally pin a branch:
    # ref = "main";
  };

  spacemacsFramework = builtins.fetchGit {
    url = "https://github.com/syl20bnr/spacemacs.git";
    # You can choose "master" or "develop"
    ref = "develop";
  };

  astroNvimTemplate = builtins.fetchGit {
    url = "https://github.com/AstroNvim/template.git";
    ref = "main";
  };

  # Helper to timestamp backups
  timestamp = "$(date +%Y%m%d-%H%M%S)";

in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "seans";
  home.homeDirectory = "/home/seans";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    pkgs.stow
  ];

  programs.bash.enable = true;
  programs.fish.enable = true;
  programs.nushell = {
    enable = true;
    settings.default = true;
  };
  programs.neovide.enable = true;
  programs.emacs.enable = true;
  programs.jujutsu.enable = true;
  programs.git.enable = true;
  programs.bat.enable = true;
  programs.btop.enable = true;
  programs.ripgrep.enable = true;
  programs.lazygit.enable = true;
  programs.lazydocker.enable = true;
  programs.uv.enable = true;
  programs.eza.enable = true;
  programs.lsd.enable = true;

  # (Optional) basic neovim shim (AstroNvim will provide the config)
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;
    withNodeJs = false;
    withRuby = false;
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 86400;
    enableSshSupport = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    # Spacemacs expects:
    #   ~/.emacs.d      -> the Spacemacs framework (repo)
    #   ~/.spacemacs.d  -> your personal config (your repo)
    #
    ".emacs.d".source = spacemacsFramework;
    ".spacemacs.d".source = "${myDotfiles}/spacemacs";
  };

  # Declare AstroNvim (template) as your Neovim config.
  # fetchGit produces a clean tree (no .git), so no need to rm -rf .git.
  xdg.enable = true;
  xdg.configFile."nvim" = {
    source = astroNvimTemplate;
    recursive = true;
    force = true;  # replace any prior directory/symlink
  };

  # Load fish functions
  xdg.configFile."fish".source = "${myDotfiles}/fish/.config/fish";

  # Configure jj
  xdg.configFile."jj".source = "${myDotfiles}/jujitsu/.config/jj";

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/seans/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
