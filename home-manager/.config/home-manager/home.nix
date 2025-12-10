{ config, pkgs, lib, ... }:

# Contents
# (Search for the boxed numbers to find the unique TOC entry)
#
# [34] Basic Settings
# [50] Allow Proprietary Software
# [59] Enable fontconfig
# [62] Unmanaged Packages
# [93] Managed Packages
# [119] Managed Packages with Customizations
# [304] Services #
# [321] Python Packages #
# [142] Dotfile Specifications
# [166] XDG Config File Specifications
# [387] Environment Variables #


# ###################
# [34] Basic Settings
# ###################
# [7] Personal Repo Setup
# [47] Add unstable packages
# [55] Define variables for postgres  
# [66] Define codex setup

let
  # #######################
  # [7] Personal Repo Setup
  # #######################

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
# [7] Personal Repo Setup

# ######################################################################
# [47] Add unstable packages (so I can live at head for certain things).
# ######################################################################

  unstable = import <nixpkgs-unstable> {};
# [47] Add unstable packages

# ##################################  
# [55] Define variables for postgres  
# ##################################  
postgres = pkgs.postgresql_17;
pgDataDir = "${config.home.homeDirectory}/.local/share/postgres";
# [55] Define variables for postgres  

# #######################
# [66] Define codex setup
# #######################
  toml = pkgs.formats.toml { };
  codexConfig = {
    # Base Settings
    model = "gpt-5.1-codex";
    approval_policy = "on-request";
    sandbox_mode = "workspace-write";

    #model_reasoning_effort = "medium";
    #model_provider = "openai";

    #model_providers = {
    #  openai = {
    #    name = "OpenAI";
    #    base_url = "https://api.openai.com/v1";
    #    env_key = "OPENAI_API_KEY";
    #    wire_api = "responses";
    #  };
    #};
  };
  codexConfigFile = toml.generate "codex-config.toml" codexConfig;
# [66] Define codex setup

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
  # [34] Basic Settings

  # #################################
  # [50] Allow Proprietary Software #
  # #################################

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "obsidian"
      "spotify"
    ];
  };
  # [50] Allow Proprietary Software #

  # ######################
  # [59] Enable fontconfig
  # ######################

  fonts.fontconfig.enable = true;
  # [59] Enable fontconfig

  # #######################
  # [62] Unmanaged Packages
  # #######################

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

    unstable.jujutsu
    pkgs.meld
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.obsidian
    pkgs.spotify
    pkgs.stow
    pkgs.xclip
    (builtins.getFlake "github:bgreenwell/doxx").packages.${pkgs.system}.default
    pkgs.maestral
    pkgs.maestral-gui
    pkgs.groff
    pkgs.inkscape
    pkgs.vlc
    pkgs.transmission_3-qt
    pkgs.tex-gyre.pagella # Palatino clone
    pkgs.eb-garamond
    #pkgs.cormorant # Decorative garamond
    pkgs.fossil
    pkgs.lyx
    pkgs.texliveFull
    pkgs.postgresql
    pkgs.codex
    pkgs.libreoffice
  ];
  # [62] Unmanaged Packages

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
  programs.info.enable = true;
  programs.man.enable = true;
  programs.gpg.enable = true;
  # [93] Managed Packages

  # ##########################################
  # [119] Managed Packages with Customizations
  # ##########################################
  # [158] programs.eza
  # [167] programs.fish
  # [176] programs.neovim
  # [189] programs.nushell
  # [198] programs.tmux
  # [336] programs.zoxide
  # [348] programs.onedrive
  # [217] programs.direnv

  # ##################
  # [158] programs.eza
  # ##################
  programs.eza = {
    enable = true;
    icons = "auto";
  };
  # [158] programs.eza

  # ###################
  # [167] programs.fish
  # ###################
  programs.fish = {
    enable = true;
    #interactiveShellInit = "${myDotfiles}/fish/.config/fish/config.fish";
  };
  # [167] programs.fish

  # #####################
  # [176] programs.neovim
  # #####################
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;
    withNodeJs = false;
    withRuby = false;
  };
  # [176] programs.neovim

  # ######################
  # [189] programs.nushell
  # ######################
  programs.nushell = {
    enable = true;
    settings.default = true;
  };
  # [189] programs.nushell

  # ###################
  # [198] programs.tmux
  # ###################
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
  # [198] programs.tmux
  
  # #####################
  # [336] programs.zoxide
  # #####################
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    options = [ "--cmd cd" ];
  };
  # [336] programs.zoxide

  # #######################
  # [348] programs.onedrive
  # #######################
  programs.onedrive = {
    enable = true;
    settings = {
      sync_dir = "%h/Cloud/onedrive";
    };
  };
  # [348] programs.onedrive

  # #####################
  # [217] programs.direnv
  # #####################
  programs.direnv = {
    enable = true;
  };
  # [217] programs.direnv
  # [119] Managed Packages with Customizations

  # ################
  # [304] Services #
  # ################

  services.gpg-agent = {
    defaultCacheTtl = 86400;
    defaultCacheTtlSsh = 86400;
    enable = true;
    enableSshSupport = true;
    maxCacheTtl = 86400;
    pinentry.package = pkgs.pinentry-curses;
  };
  # [304] Services #

  # #######################
  # [321] Python Packages #
  # #######################

  # Python is a tricky bird, but there are a lot of useful programs and apps
  # written in it. Therefore, I want to centralize management of those. My plan
  # is to use UV to install and manage any package that is not already in Nix
  # packages or whose version is too old.
  # [321] Python Packages #

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
    ".codex/config.toml".source = codexConfigFile;
    ".codex/AGENTS.md".text = ''
      - You are my terminal coding agent. 
      - Prefer Nix, C++, and Python3 examples. 
      - Assume I use git, jujutsu, NixOS, Neovim, and home-manager.
    '';
  };
  # [142] Dotfile Specifications

  # ####################################
  # [166] XDG Config File Specifications
  # ####################################
  # [416] qfreplace.lua
  # [431] telescope.lua
  # [456] vim-surround.nvim
  # [471] fish/functions
  # [479] git/config
  # [490] jj/config.toml
  # [499] maestral.desktop

  # Declare AstroNvim (template) as your Neovim config.
  # fetchGit produces a clean tree (no .git), so no need to rm -rf .git.
  xdg.enable = true;
  xdg.configFile."nvim" = {
    source = astroNvimTemplate;
    recursive = true;
    force = true;  # replace any prior directory/symlink
  };
  # ###################
  # [416] qfreplace.lua
  # ###################
  xdg.configFile."nvim/lua/plugins/qfreplace.lua".text = ''
  return {
    { 
      "thinca/vim-qfreplace", 
      cmd = "Qfreplace",
      keys = { { "<leader>xr", "<cmd>Qfreplace<cr>", desc = "Edit Quickfix" } },
      opts = {},
    },
  }
  '';
  # [416] qfreplace.lua

  # ###################
  # [431] telescope.lua
  # ###################
  xdg.configFile."nvim/lua/plugins/telescope.lua".text = ''
  return {
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      cmd = "Telescope",
      keys = {
        { "<leader>fG", function() require( "telescope.builtin" ).live_grep() end, desc = "Live Grep" },
      },
      opts = function( _, opts )
        local v = require( "telescope.config" ).values
        opts = opts or {}
        opts.defaults = opts.defaults or {}
        opts.defaults.vimgrep_arguments = v.vimgrep_arguments
        return opts
      end,
    },
  }
  '';
  # [431] telescope.lua

  # #######################
  # [456] vim-surround.nvim
  # #######################
  xdg.configFile."nvim/lua/plugins/vim-surround.nvim".text = ''
    return {
      {
        "kylechui/nvim-surround",
        cmd = "Vsurround",
        opts = {},
      }
    }
  '';
  # [456] vim-surround.nvim

  # ####################
  # [471] fish/functions
  # ####################
  xdg.configFile."fish/functions".source = config.lib.file.mkOutOfStoreSymlink "${myDotfiles}/fish/.config/fish/functions";
  #xdg.configFile."fish/config.fish".source = config.lib.file.mkOutOfStoreSymlink "${myDotfiles}/fish/.config/fish/config.fish";
  # [471] fish/functions

  # ################
  # [479] git/config
  # ################
  xdg.configFile."git/config" = {
    text = ''
      [user]
      	name = Sean R. Spillane
      	email = sean@spillane.us
      	signingkey = /home/seans/.ssh/id_ed25519.pub
      
      [color]
      	diff = auto
      	status = auto
      	branch = auto
      	interactive = auto
      	ui = true
      	pager = true
      
      [color "branch"]
      	# current = blue reverse
      	# local = blue
      	# remote = green
      	current = magenta reverse
      	local = default
      	remote = yellow reverse
      	upstream = green reverse
      	plain = blue
      
      [color "diff"]
      	meta = yellow bold
      	frag = magenta bold
      	old = red bold
      	new = green bold
      
      [color "status"]
      	added = green
      	changed = magenta
      	untracked = cyan
      
      [color "decorate"]
      	HEAD = red
      	branch = cyan
      	tag = yellow
      	remoteBranch = magenta
      
      [core]
      	pager = less -FRSX
      	whitespace = fix,-indent-with-non-tab,trailing-space,cr-at-eol
      	autocrlf = input
      	quotepath = false
      	editor = nvim -O
      
      # URL shortcuts
      [url "git@github.com:tokuchan/"]
      	insteadOf = "srs:"
      
      [url "git@github.com:"]
      	insteadOf = "gh:"
      
      [url "git@github.com:keplercompute/"]
      	insteadOf = "kepler:"
      
      [url "git@github.com:helixcompute/"]
      	insteadOf = "helix:"
      
      [url "ssh://git@github.com"]
      	insteadOf = https://github.com
      
      [status]
      	branch = true
      	showStash = true
      	showUntrackedFiles = all
      
      [log]
      	abbrevCommit = true
      	graphColors = blue,yellow,cyan,magenta,green,red
      
      [branch]
      	sort = -committerdate
      
      [tag]
      	sort = -taggerdate
      
      [pager]
      	branch = false
      	tag = false
      
      [alias]
      	aliases = !$HOME/.local/bin/aliases.py
      	attach = "!f () { git branch --force $1 && git checkout $1; }; f"
      	branches = branch -a
      	changes = "log-pretty --no-merges --max-count=15 --graph"
      	detach = "checkout --detach"
      	patches = "changes patches...master"
      	last = "log-pretty --max-count=1"
      	log-pretty = "!f () { git log --pretty='format:%(trailers:key=Change-Id,valueonly,separator=%x2C) %C(dim green) %<(12,trunc)%ar %C(bold magenta)%h%Creset %C(green)%<(24,trunc)%an %C(italic #ff8800)%s' $@; }; f"
      	ready = diff --cached
      	remotes = remote -v
      	sweep = clean -fdi
      	tags = tag
      
      	do = "!f () { cd $(git rev-parse --show-toplevel); $*; }; f"
      	fix = "!f() { $EDITOR $(git diff --name-only); }; f"
      	tree = log --all --graph --decorate --oneline --simplify-by-decoration
      	unstage = reset HEAD --
      
      	a = add
      	br = branch
      	c = commit
      	co = checkout
      	cp = cherry-pick
      	df = diff
      	fo = fetch origin
      	lg = log
      	pos = push --set-upstream origin
      	p = pull
      	pp = push
      	rs = restore --staged
      	st = status
      	tg = tag
      	regen-aliases = "!for a in $($HOME/dev/config/aliases.py -f simple -D); do fish -c alias g$a='g $a'; done"
      	gpush = push gerrit patches:refs/for/master
      	log-exclude = "!f() { br=$(git branch --show-current); git log \"''${br}\" --not $(git for-each-ref --format='%(refname)' refs/heads/ | grep -v \"refs/heads/''${br}\") $*; }; f"
      	current-branch = "!f() { test -z \"''${1}\" && git rev-parse --abbrev-ref HEAD || echo $1; }; f"
      	log-br = "!f() { git log --oneline $(git current-branch $1)...local-master; }; f"
      	pull-rebase = "!f(){ git switch master && git pull --no-edit && git submodule update --init && git switch patches && git rebase; git status; }; f"
      	pull-master = "!f(){ b=$(git current-branch); git switch master && git pull --no-edit && git submodule update --init && git switch \"''${b}\"; }; f"
      	pull-local-master = "!f(){ b=$(git current-branch); git switch local-master && git pull-master && git pull --no-edit && git submodule update --init && git switch \"''${b}\"; }; f"
      	rebase-patches = "!f(){ b=$(git current-branch); git switch patches && git rebase && git switch \"''${b}\"; }; f"
      	send = "!f() { br=$(git current-branch); pt=\"''${*:-$(git log --oneline --no-abbrev-commit | head -1 | cut -d' ' -f1)}\"; test \"''${br}\" != patches && git switch patches && (git cherry-pick \"''${pt}\" || git cherry-pick --abort) && git switch \"''${br}\"; git log --oneline patches...master; }; f"
      	f = fuzzy-fetch
      	g = "!f() { git branchless switch --interactive $@ || git-goto $@; }; f"
      	freshen = "!f() { set -x; git clean -xfd && git submodule foreach --recursive git clean -xfd && git reset --hard && git submodule foreach --recursive git reset --hard && git submodule update --init --recursive; set +x; }; f"
      	md = "log --no-merges master..HEAD --format=\"## %s%n%n%b%n\""
      
      [pull]
      	rebase = false
      	default = current
      
      [push]
      	autoSetupRemote = true
      	default = current
      	followTags = true
      
      [rebase]
      	autoStash = true
      	missingCommitsCheck = warn
      
      [diff]
      	#tool = vimdiff
      	context = 3
      	renames = copies
      	interHunkContxt = 10
      
      [difftool]
      	prompt = false
      [difftool "nvimdiff"]
      	cmd = "nvim -d \"$LOCAL\" \"$REMOTE\""
      [merge]
      	tool = vimdiff
      [mergetool]
      	prompt = true
      [mergetool "nvimdiff"]
      	#cmd = "nvim -d \"$LOCAL\" \"$REMOTE\" \"$BASE\" \"$MERGED\""
      	layout = "LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE + (LOCAL/BASE/REMOTE),MERGED"
      [mergetool "vimdiff"]
      	layout = "LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE + (LOCAL/BASE/REMOTE),MERGED"
      [init]
      	defaultBranch = master
      [rerere]
      	enabled = false
      [status]
      	submodulesummary = true
      [guitool "Stage by edit in term"]
      	cmd = xterm -fa 'fixed' -fs 14 -e git stage -e $FILENAME
      
      [diff]
      	ignoreSubmodules = dirty
      [advice]
      	skippedCherryPicks = false
      
      [difftool "branchless"]
      	cmd = git-branchless difftool --read-only --dir-diff $LOCAL $REMOTE
      
      [mergetool "branchless"]
      	cmd = git-branchless difftool $LOCAL $REMOTE --base $BASE --output $MERGED
      [submodule]
      	recurse = true
      [credential]
      	helper = /mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe
      [commit]
      	gpgsign = true
      	verbose = true
      [gpg]
      	format = ssh
    '';
    force = true;
  };
  # [479] git/config

  # ####################
  # [490] jj/config.toml
  # ####################
  home.activation.removeOldJjDir = lib.hm.dag.entryBefore [ "linkGeneration" ] ''
    rm -rf "$HOME/.config/jj"
  '';
  xdg.configFile."jj/config.toml" = {
    text = ''
      "$schema" = "https://jj-vcs.github.io/jj/latest/config-schema.json"
      
      [user]
      name = "Sean R. Spillane"
      email = "sean@spillane.us"
      
      [ui]
      pager = "less -FRX"
      default-command = ['util', 'exec', '--', 'bash', '-c', """
      jj status
      echo Log:
      jj log -n 10 -r 'ancestors(@,5)::descendants(@,5)'
      """, ""]
      
      [templates]
      draft_commit_description = """
      concat(
        description,
        surround(
          "\nJJ: This commit contains the following changes:\n", "",
          indent("JJ:     ", diff.summary()),
        ),
        surround(
          "\nJJ: This commit contains the following changes:\n", "",
          indent("JJ:     ", diff.stat(72)),
        ),
        "\n",
        indent("JJ: ", diff.git()),
        "JJ: ignore-rest\n",
      )
      """
      
      [aliases]
      pullup = [
        "util", "exec", "--",
        "bash", "-c", """
          set -euo pipefail
          if [ $# -ge 1 ]; then
            branch=$1
          else
            # List the bookmarks on the working-copy commit and take the first
            names=$(jj log --template 'bookmarks ++ "\n"' --no-graph | grep . | head -1)
            branch=''${names%%,*}
          fi
          # Move that bookmark back one commit
          echo jj bookmark move --from "$branch" --to @-
          jj bookmark move --from "$branch" --to @-
        """,
        "_"  # placeholder for $0
      ]
      aliases = ["util", "exec", "--", "bash", "-c", """
      #!/bin/bash 
      set -euo pipefail
      jj config list aliases | pygmentize -l toml -f 16m -O style=dracula
      """, ""]
      
      up = ["util", "exec", "--", "bash", "-c", """
      #!/bin/bash
      set -euo pipefail
      if [ $# -gt 1 ]; then
        cat >&2 <<-'EOF'
        Usage: jj up [n=1]
      
        Go forward 1 or more commits.
      EOF
        exit 1
      fi
      n=''${1:-1}
      rev=$(
        jj log \
          -r "descendants(@,$((n+1))) ~ descendants(@,$n)" \
          --template 'self.change_id()' \
          --no-graph
      )
      
      jj edit "$rev"
      """, ""]
      
      down = ["util", "exec", "--", "bash", "-c", """
      #!/bin/bash
      set -euo pipefail
      if [ $# -gt 1 ]; then
        cat >&2 <<-'EOF'
        Usage: jj down [n=1]
      
        Go back 1 or more commits.
      EOF
        exit 1
      fi
      n=''${1:-1}
      rev=$(
        jj log \
          -r "ancestors(@,$((n+1))) ~ ancestors(@,$n)" \
          --template 'self.change_id()' \
          --no-graph
      )
      
      jj edit "$rev"
      """, ""]
    '';
    force = true;
  };
  # [490] jj/config.toml

  # ######################
  # [499] maestral.desktop
  # ######################
  xdg.desktopEntries.maestral = {
    name = "Maestral";
    genericName = "Dropbox Client";
    exec = "${pkgs.maestral-gui}/bin/maestral_qt";
    terminal = false;
    categories = [ "Network" "FileTransfer" ];
  };
  xdg.configFile."autostart/maestral.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Maestral
    Comment=Dropbox Client
    Exec=${pkgs.maestral-gui}/bin/maestral_qt
    Terminal=false
    X-GNOME-Autostart-enabled=true
  '';
  xdg.configFile."maestral/default.ini".text = ''
    # Example keys; Maestral writes most of this itself after first run.
    # See docs for available settings.
    # https://www.maestral.app/docs/configfile
    # notification_level = "FILECHANGE"
    # reindex_interval = 3600
  '';
  # [499] maestral.desktop
  # [166] XDG Config File Specifications

  # #############################
  # [387] Environment Variables #
  # #############################

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
    PGDATA = pgDataDir;
    PGPORT = "5432";
  };
  # [387] Environment Variables #

  # THIS MUST BE THE LAST LINE
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # THIS MUST BE THE LAST LINE
}
