set -gx PATH $PATH (readlink -f ~/.local/share/rust/cargo/bin)
set -gx CARGO_HOME (readlink -f ~/.local/share/rust/cargo)
set -gx RUSTUP_HOME (readlink -f ~/.local/share/rust/rustup)
set -gx PATH "$HOME/.cargo/bin" $PATH
