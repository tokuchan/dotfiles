# Ensure that dotfiles packages are available to run
set -gx PATH $PATH ~/.local/bin
set -gx MANPATH $MANPATH ~/.local/man

# Tell subprograms to use bash
set -x SHELL /bin/bash

# Set up pyenv
set -gx PYENV_ROOT "$HOME/.pyenv"
if not command -v pyenv >/dev/null
  set -gx PATH "$PYENV_ROOT/bin" $PATH
end
pyenv init --no-rehash - | source

if status is-interactive
    # Commands to run in interactive sessions can go here

    # Set the terminal to xterm256-color by default
    set -gx "TERM" "xterm-256color"
end

