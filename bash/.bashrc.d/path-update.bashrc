# Load user filesystem hierarchy
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

# Load maystreet-specific binaries
if ! [[ "$PATH" =~ "/data/archive/mst_tools/latest/" ]]
then
    PATH="$PATH:/data/archive/mst_tools/latest/"
fi

# Finalize PATH 
export PATH
