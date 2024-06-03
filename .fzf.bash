# Setup fzf
# ---------
if [[ ! "$PATH" == */home/alex/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/alex/.fzf/bin"
fi

eval "$(fzf --bash)"
