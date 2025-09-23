{ config, pkgs, lib, ... }:

# Contents
# (Search for the boxed numbers to find the unique TOC entry)
#
# [7] Personal Repo Setup
# [34] Basic Settings
# [50] Install Proprietary Software
# [59] Enable fontconfig
# [62] Unmanaged Packages
# [93] Managed Packages
# [119] Managed Packages with Customizations
# [142] Dotfile Specifications
# [166] XDG Config File Specifications


# #######################
# [7] Personal Repo Setup
# #######################

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
  # ###################
  # [34] Basic Settings
  # ###################

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

  # [50] Install Proprietary Software
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "obsidian"
      "spotify"
    ];
  };

  # ######################
  # [59] Enable fontconfig
  # ######################

  fonts.fontconfig.enable = true;

  # #######################
  # [62] Unmanaged Packages
  # #######################

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
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

    jujutsu
    meld
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    obsidian
    spotify
    stow
    xclip
  ];

  # #####################
  # [93] Managed Packages
  # #####################

  # Note that these include embedded configurations, and also refer to the XDG
  # configurations given later.

  programs.bash.enable = true;
  programs.bat.enable = true;
  programs.btop.enable = true;
  programs.emacs.enable = true;
  programs.git.enable = true;
  programs.jujutsu.enable = false;
  programs.lazydocker.enable = true;
  programs.lazygit.enable = true;
  programs.lsd.enable = true;
  programs.neovide.enable = true;
  programs.ripgrep.enable = true;
  programs.uv.enable = true;

  # ##########################################
  # [119] Managed Packages with Customizations
  # ##########################################

  programs.eza = {
    enable = true;
    icons = "auto";
  };

  programs.fish = {
    enable = true;
    #interactiveShellInit = "${myDotfiles}/fish/.config/fish/config.fish";
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;
    withNodeJs = false;
    withRuby = false;
  };

  programs.nushell = {
    enable = true;
    settings.default = true;
  };

  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    terminal = "tmux-256color";
    historyLimit = 100000;
    plugins = with pkgs;
    [
      tmuxPlugins.sensible
      tmuxPlugins.catppuccin
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.tmux-fzf
      tmuxPlugins.yank
      tmuxPlugins.pass
      tmuxPlugins.jump
      tmuxPlugins.urlview
      tmuxPlugins.resurrect
    ];
    extraConfig = ''
# Set the prefix to Control-Space
unbind C-b
set -g prefix C-s
bind C-s command-prompt
bind C-a send-prefix

# Use Spacemacs-style window split commands
bind | split-window -h -c "#{pane_current_path}"
bind / split-window -h -c "#{pane_current_path}"
bind '\' split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"
unbind '"'
unbind %

# Open new windows in the same path
bind c new-window -c "#{pane-current-path}"

# Bind r to reload the tmux config
bind r source-file ~/.config/tmux/tmux.conf

# Shorten command delay
set -sg escape-time 1

# Don't let tmux rename tabs automatically
set -g allow-rename off

# Enable VI mode
set-option -g mouse on
set-window-option -g mode-keys vi
set-option -s set-clipboard on
bind-key -T copy-mode-vi v send-keys -X begin-selection
bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

# Add prefix bindings to move between panes
unbind h
bind h select-pane -L
unbind l
bind l select-pane -R
unbind k
bind k select-pane -U
unbind j
bind j select-pane -D

## Present a menu of URLs to open from the visible pane
#bind u capture-pane \;\
#  save-buffer /tmp/tmux-buffer \;\
#  split-window -l 10 "urlview /tmp/tmux-buffer"
#
## Modes
#setw -g clock-mode-colour colour5
#setw -g mode-style 'fg=colour1 bg=colour18 bold'
#
## Panes
#set -g pane-border-style 'fg=colour19 bg=colour0'
#set -g pane-active-border-style 'fg=colour9 bg=colour0'
#
# Status Bar
set -g status-position top
#set -g status-justify left
#set -g status-style 'fg=colour137 bg=colour18 dim'
#set -g status-left ""
#set -g status-right '#[fg=colour137,bg=colour19] %d/%m/%y #[fg=colour137,bg=colour8] %H:%M:%S '
#set -g status-right-length 50
#set -g status-left-length 20
#
#setw -g window-status-current-style 'fg=colour1 bg=colour19 bold'
#setw -g window-status-current-format ' #I#[fg=colour249]:#[fg=colour255]#W#[fg=colour249]#F '
#
#setw -g window-status-style 'fg=colour9 bg=colour18'
#setw -g window-status-format ' #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F'
#
#setw -g window-status-bell-style 'fg=colour255 bg=colour1 bold'
#
## Messages
#set -g message-style 'fg=colour232 bg=colour16 bold'

# Number windows starting at 1
set -g base-index 1
set -g pane-base-index 1
set-window-option -g pane-base-index 1
set-option -g renumber-windows on

# Fix colors
set-option -sa terminal-overrides ",xterm*:Tc"

# Use Shift+Alt+{h,l} to navigate windows
# bind -n M-h previous-window
# bind -n M-l next-window
# unbind H
# bind H previous-window
# unbind L
# bind L next-window
# bind Left previous-window
# bind Right next-window

# Override the order of the menu items:
TMUX_FZF_ORDER="session|window|pane|command|keybinding|process|clipboard"
# Set up a custom tmux-fzf menu of commands:
#"menu-entry\necho command to run\n"
TMUX_FZF_MENU=\
"sgr\nsgr\n"\
"tmux-fzf-url\necho 'https://github.com/sainnhe/tmux-fzf'\n"

# Set up pane and window splits that make sense to me.
unbind s
bind s split-pane -c '#{pane_current_path}'
unbind v
bind v split-pane -h -c '#{pane_current_path}'
unbind t
bind t new-window -c '#{pane_current_path}'
unbind d
bind d kill-pane
    '';
  };
  
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    options = [ "--cmd cd" ];
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 86400;
    enableSshSupport = true;
  };

  # ############################
  # [142] Dotfile Specifications
  # ############################

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

  # ####################################
  # [166] XDG Config File Specifications
  # ####################################

  # Declare AstroNvim (template) as your Neovim config.
  # fetchGit produces a clean tree (no .git), so no need to rm -rf .git.
  xdg.enable = true;
  xdg.configFile."nvim" = {
    source = astroNvimTemplate;
    recursive = true;
    force = true;  # replace any prior directory/symlink
  };

  # Load fish functions
  xdg.configFile."fish/functions".source = config.lib.file.mkOutOfStoreSymlink "${myDotfiles}/fish/.config/fish/functions";
  #xdg.configFile."fish/config.fish".source = config.lib.file.mkOutOfStoreSymlink "${myDotfiles}/fish/.config/fish/config.fish";

  # Configure git
  xdg.configFile."git/config".source = "${myDotfiles}/git-config/.config/git/config";

  # Configure jj
  xdg.configFile."jj/config.toml".source = "${myDotfiles}/jujitsu/.config/jj/config.toml";

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
