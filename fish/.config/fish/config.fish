# Ensure that dotfiles packages are available to run
set -gx PATH ~/.local/bin $PATH
set -gx PATH ~/.nix-profile/bin/ $PATH
set -gx MANPATH $MANPATH ~/.local/man:

# Tell subprograms to use bash
set -x SHELL bash

# Set up pyenv
#set -gx PYENV_ROOT "$HOME/.pyenv"
#if not command -v pyenv >/dev/null
#  set -gx PATH "$PYENV_ROOT/bin" $PATH
#end
#pyenv init --no-rehash - | source

if status is-interactive
    # Commands to run in interactive sessions can go here

    # Set the terminal to xterm256-color by default
    set -gx "TERM" "xterm-256color"
    #set-display
end

set -gx PATH "$HOME/.cargo/bin" $PATH

# We should try to connect to openport so the Reverse SSH stuff is running.
set-up-openport


thefuck --alias | source
