# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# First checks if tmux is installed. 
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
PROMPT_COMMAND='history -a'

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

# Ignore case on auto-completion
# Note: bind used instead of sticking these in .inputrc
if [[ $iatest -gt 0 ]]; then bind "set completion-ignore-case on"; fi

# Show auto-completion list automatically, without double tab
if [[ $iatest -gt 0 ]]; then bind "set show-all-if-ambiguous On"; fi

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	;;
*) ;;
esac

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

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
# if [ -f ~/.bash_aliases ]; then
# 	. ~/.bash_aliases
# fi

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

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

export PATH="$PATH:/opt/nvim-linux64/bin"
export MANPATH="usr/local/texlive/2024/texmf-dist/doc/man:$MANPATH"
export INFOPATH="usr/local/texlive/2024/texmf-dist/doc/info:$INFOPATH"
export PATH="/usr/local/texlive/2024/bin/x86_64-linux:$PATH"
export PATH="/home/alex/.cargo/bin:$PATH"
export PATH="/home/alex/.fzf/bin:$PATH"

export GCM_CREDENTIAL_STORE=gpg

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export VISUAL=nvim
export EDITOR=nvim
# export PAGER=nvim

# Enable fzf key bindings
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Enable fzf auto-completion
[ -f ~/.fzf/completion.bash ] && source ~/.fzf/completion.bash

eval "$(starship init bash)"
eval "$(fzf --bash)"
