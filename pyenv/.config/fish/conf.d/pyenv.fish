set -Ux PYENV_ROOT $HOME/.pyenv
echo $PATH | grep $PYENV_ROOT >/dev/null || fish_add_path $PYENV_ROOT/bin
pyenv init - | source
