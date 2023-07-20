if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Set up variables for homebrew
set -gx HOMEBREW_PREFIX "/opt/homebrew";
set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar";
set -gx HOMEBREW_REPOSITORY "/opt/homebrew";
set -q PATH; or set PATH ''; set -gx PATH "/opt/homebrew/bin" "/opt/homebrew/sbin" $PATH;
set -q MANPATH; or set MANPATH ''; set -gx MANPATH "/opt/homebrew/share/man" $MANPATH;
set -q INFOPATH; or set INFOPATH ''; set -gx INFOPATH "/opt/homebrew/share/info" $INFOPATH;

# Set up autojump
if which autojump > /dev/null
  source (which autojump | sed 's,bin.*$,,')/share/fish/vendor_conf.d/autojump.fish
else
  echo "Autojump not installed"
end

# Tell subprograms to use bash
set -x SHELL /bin/bash

# Created by `pipx` on 2022-03-14 15:48:49
set PATH $PATH /Users/sspillane/.local/bin
set PATH $PATH ~/.local/bin

# Set up pyenv
#status is-login; and pyenv init --path | source
#status is-interactive; and pyenv init - | source

# Ensure nvim plug is installed
#nvim --headless +PlugInstall +qall

#pyenv init - | source

