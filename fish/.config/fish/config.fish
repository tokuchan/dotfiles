if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Clear PATH and set defaults
#set -e PATH
#set -gx PATH /home/seans/.local/bin:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:/home/seans/.pyenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin

# Set up variables for homebrew
#set -gx HOMEBREW_PREFIX "/opt/homebrew";
#set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar";
#set -gx HOMEBREW_REPOSITORY "/opt/homebrew";
#set -q PATH; or set PATH ''; set -gx PATH "/opt/homebrew/bin" "/opt/homebrew/sbin" $PATH;
#set -q MANPATH; or set MANPATH ''; set -gx MANPATH "/opt/homebrew/share/man" $MANPATH;
#set -q INFOPATH; or set INFOPATH ''; set -gx INFOPATH "/opt/homebrew/share/info" $INFOPATH;

# Set up variables for homebrew
#eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)


# Set up autojump
if which autojump > /dev/null
  source (which autojump | sed 's,bin.*$,,')/share/autojump/autojump.fish
else
  echo "Autojump not installed"
end

# Set up pyenv
set -gx PYENV_ROOT "$HOME/.pyenv"
if not command -v pyenv >/dev/null
  set -gx PATH "$PYENV_ROOT/bin" $PATH
end
pyenv init --no-rehash - | source

# Tell subprograms to use bash
set -x SHELL /bin/bash

# Created by `pipx` on 2022-03-14 15:48:49
set PATH $PATH /Users/sspillane/.local/bin
set PATH $PATH ~/.local/bin

# Set the terminal to xterm256-color by default
set -gx "TERM" "xterm-256color"
