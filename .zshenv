export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH="$PATH:/opt/nvim-linux64/bin"
export MANPATH="usr/local/texlive/2024/texmf-dist/doc/man:$MANPATH"
export INFOPATH="usr/local/texlive/2024/texmf-dist/doc/info:$INFOPATH"
export PATH="/usr/local/texlive/2024/bin/x86_64-linux:$PATH"
export PATH="/home/alex/.cargo/bin:$PATH"
export PATH="/home/alex/.fzf/bin:$PATH"

export GCM_CREDENTIAL_STORE=gpg

# lazy loading nvm stuff because it's slow as shit
load_nvm() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}
alias nvm="load_nvm; nvm"
alias node="load_nvm; node"
alias npm="load_nvm; npm"
alias npx="load_nvm; npx"

export VISUAL=nvim
export EDITOR=nvim
# export PAGER=nvim

