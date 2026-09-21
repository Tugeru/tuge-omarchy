# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load.
ZSH_THEME="robbyrussell"

# Completion behavior.
# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"

# Oh My Zsh update behavior.
# zstyle ':omz:update' mode disabled
# zstyle ':omz:update' mode auto
# zstyle ':omz:update' mode reminder
# zstyle ':omz:update' frequency 13
# zstyle ':omz:update' cooldown 10

# Shell behavior.
# DISABLE_MAGIC_FUNCTIONS="true"
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# HIST_STAMPS="yyyy-mm-dd"

# Custom Oh My Zsh installation directory.
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(git)

source "$ZSH/oh-my-zsh.sh"

# Completion menu behavior. Oh My Zsh provides compinit; these options only
# change how its existing completion system behaves.
zstyle ':completion:*' menu select
setopt AUTO_MENU
setopt COMPLETE_IN_WORD

# Fish-like history suggestions.
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Highlight commands as they are typed. Keep this plugin last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
