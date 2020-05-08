# Auto-generated stuff
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
bindkey -e
zstyle :compinstall filename '/home/joshuas/.zshrc'
autoload -Uz compinit
compinit

# Joppy-changes
autoload -U zmv
autoload -U colors && colors
setopt prompt_subst

# Location of Git promt for Debian
. /usr/lib/git-core/git-sh-prompt

# Red is a snep colour :3
COLOUR_THEME=red
PROMPT='%F{${COLOUR_THEME}}%B%K{${COLOUR_THEME}} %F{white}%K{${COLOUR_THEME}}%B%n@%m%b%F{${COLOUR_THEME}}%k█▓▒%b%k%f$(__git_ps1) %% '
RPROMPT="%F{${COLOUR_THEME}}%B%~/%b%k%f"

# Alias
alias ls='ls --color=auto'
alias grep='grep --color=auto'
