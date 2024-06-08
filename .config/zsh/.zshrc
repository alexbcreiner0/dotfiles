# Uncomment this to get a log of what happens with every line of this zshrc file on starting up a terminal
# set -x
# If you come from bash you might have to change your $PATH.
# Run tmux on startup
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

# Load environment vars
source "/home/alex/.config/zsh/.zshenv"

#TODO: Move the history to the config folder to share it between systems
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=/home/alex/.zsh_history

# According to ChatGPT:
# This sets the auto_pushd option in zsh. With this option enabled, every time you cd into a new directory, the previous directory is automatically pushed onto a directory stack. This allows you to quickly navigate back to previously visited directories using the pushd, popd, and dirs commands.
setopt auto_pushd

# Initialize the autocompletion. The -u option restricts completion in some ways for security reasons 
autoload compinit 
zstyle ':completion:*' menu select
# Sets up fancier smart matching
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist # loads a module that make everything better
compinit -u
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Enable searching through history
bindkey '^R' history-incremental-pattern-search-backward

# Initialize plugins
eval "$(starship init zsh)"
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Enable fzf key bindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Enable fzf auto-completion
[ -f ~/.fzf/completion.zsh ] && source ~/.fzf/completion.zsh

source /home/alex/.config/zsh/plugins/zsh_autosuggestions/zsh-autosuggestions.zsh

fpath=(/home/alex/.config/zsh/plugins/zsh-completions/src $fpath)

source /home/alex/.config/zsh/plugins/zsh-autopairs/autopair.zsh

source /home/alex/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source /home/alex/.config/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
    alias nvim-python-example='NVIM_APPNAME="nvim-python-starter" nvim'
    alias nvim-test='NVIM_APPNAME="nvim-rebuild" nvim'
fi

# lazy loading nvm stuff because it's slow as shit
function load_nvm {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}
alias nvm="load_nvm; nvm"
alias node="load_nvm; node"
alias npm="load_nvm; npm"
alias npx="load_nvm; npx"

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
# alias rm='trash -v'
# alias RM='rm'
alias obsidian='flatpak run md.obsidian.Obsidian &'
alias chrome='flatpak run com.google.Chrome &'
alias python='python3'
alias cat='batcat --paging=never'
alias play-around='test-func'
alias nvim-ytguy="NVIM_APPNAME='youtube_guy_latex_nvim' nvim"

function test-func {
    local var=$1
    
    if findmnt -rno TARGET "/home/alex/Laptop-Server"; then
        echo 'Mounted'
    else
        echo 'Not mounted'
    fi
}

# this comes with bashrc, no idea if it still matters
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Allows you to press shift+q in order to exit ranger and simultaneously cd to the directory ranger was looking at
function ranger {
    local IFS=$'\t\n'
    local tempfile="$(mktemp -t tmp.XXXXXX)"
    local ranger_cmd=(
        command
        ranger
        --cmd="map Q chain shell echo %d > "$tempfile"; quitall"
    )
    
    ${ranger_cmd[@]} "$@"
    if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
        cd -- "$(cat "$tempfile")" || return
    fi
    command rm -f -- "$tempfile" 2>/dev/null
}

function lazy-commit {
    local commit_msg="$1"

    git add .
    if [ -z "$commit_msg" ]; then
        commit_msg=$(date +"%Y-%m-%d")
    fi
    git commit -m "$commit_msg"
    git push
}

function con-laptop {
    local user="$1"

    if nc -z -w5 10.0.0.19 22; then
        ssh "${user}@10.0.0.19"
    else
        ssh "${user}@24.218.16.45"
    fi
}

function mount-server {
    local user="$1"

    if [[ "$user" == "creiner" || "$user" == "" ]]; then
        user="creiner"
        local mount_point="/home/alex/Laptop-Server"
        local server_folder="/home/creiner/Laptop-Server"
        local port=22
    elif [[ "$user" == "grace" ]]; then
        local mount_point="/home/alex/Generic-Mountpoint"
        local server_folder="/home/grace"
        local port=22
    elif [[ "$user" == "guest" ]]; then
        local mount_point="/home/alex/Generic-Mountpoint"
        local server_folder="/home/guest"
        local port=22
    elif [[ "$user" == "plex" ]]; then
        user="creiner"
        local mount_point="/home/alex/Plex-Media"
        local server_folder="/var/lib/plexmediaserver/Library/Media"
        local port=22
    fi

    if findmnt -rno TARGET "$mount_point"; then
        echo "It looks like ${mount_point} is currently already being mounted: "
        ls "$mount_point"
        echo "Would you like to unmount this in order to mount ${server_folder}? (y/n)"
        read user_input
        if [[ "$user_input" == "y" ]]; then
            umount "$mount_point"
        elif [[ "$user_input" == "n" ]]; then
            echo "Not unmounting. Done"
            return 1
        else
            echo "Invalid answer. Please enter y or n next time you try this."
            return 1
        fi
    fi
        
    if nc -z -w5 10.0.0.19 "$port"; then
        sshfs -p "${port}" "${user}@10.0.0.19:${server_folder}" "${mount_point}"
    else
        sshfs -p "${port}" "${user}@24.218.16.45:${server_folder}" "${mount_point}"
    fi

    echo "Successfully mounted ${server_folder} at location ${mount_point}"
}

# IP address lookup
alias whatismyip="whatsmyip"
function whatsmyip ()
{
	# Internal IP Lookup.
	if [ -e /sbin/ip ]; then
		echo -n "Internal IP: "
		/sbin/ip addr show wlo1 | grep "inet " | awk -F: '{print $1}' | awk '{print $2}'
	else
		echo -n "Internal IP: "
		/sbin/ifconfig wlo1 | grep "inet " | awk -F: '{print $1} |' | awk '{print $2}'
	fi

	# External IP Lookup
	echo -n "External IP: "
	curl -s ifconfig.me
}

# fastfetch
(sleep 0.3 && fastfetch)

