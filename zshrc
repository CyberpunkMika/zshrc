PATH="$HOME/.local/bin:$PATH"

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit snippet OMZ::plugins/git/git.plugin.zsh

# Add in snippet
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::debian
zinit snippet OMZP::command-not-found
# Personal additions
zinit snippet OMZP::virtualenv
zinit snippet OMZP::ssh-agent
zinit snippet OMZP::python
zinit snippet OMZP::pip
zinit snippet OMZP::podman
zinit snippet OMZP::oc
zinit snippet OMZP::nmap
zinit snippet OMZP::jsontools
zinit snippet OMZP::jira # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/jira
zinit snippet OMZP::history
zinit snippet OMZP::gitignore
zinit snippet OMZP::github # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/github
zinit snippet OMZP::gh

# Load completions
autoload -U compinit && compinit

zinit cdreplay -q

#Load zsh-history-substring-search
zinit load 'zsh-users/zsh-history-substring-search'
zinit ice wait atload '_history_substring_search_config'

# Source/Load oh-my-posh
# eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/nordcustom_v.2.omp.json)"
# eval "$(oh-my-posh init zsh --config $HOME/.config/night-owl.omp.json)"
eval "$(oh-my-posh init zsh --config ~/dev-temp/omp-themes/attempt3.omp.json)"

# Keybindings
bindkey -e
#bindkey '^p' history-search-backward
#bindkey '^n' history-search-forward
bindkey '^p' history-substring-search-up
bindkey '^n' history-substring-search-down
#bindkey '^[[A' history-substring-search-up
#bindkey '^[[B' history-substring-search-down
#bindkey ''^[[1;5A' history-substring-search-up
#bindkey ''^[[1;5B' history-substring-search-down

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Other zstyle options
zstyle ':omz:plugins:ssh-agent' agent-forwarding yes
zstyle ':omz:plugins:ssh-agent' identities ~/.ssh/putty_id_rsa

# Aliases
alias ls='ls --color'
alias cls='clear'
alias bat='batcat'

# Shell integrations
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
