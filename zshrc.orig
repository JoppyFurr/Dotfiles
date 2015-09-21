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

# This git location may not be standard.
. /usr/share/git/git-prompt.sh

# Make the zsh colour scheme match the terminal background :3
if [ -n "$LC_COLOUR_THEME" ] ; then
    COLOUR_THEME=$LC_COLOUR_THEME
    TERM=xterm-256color
else
    COLOUR_THEME=magenta
fi

# If we are root, use red instead
# if [ `whoami` == "root" ] ; then
#     COLOUR_THEME=red
# fi

PROMPT='%F{${COLOUR_THEME}}%B%K{${COLOUR_THEME}} %F{white}%K{${COLOUR_THEME}}%B%n@%m%b%F{${COLOUR_THEME}}%k█▓▒%b%k%f$(__git_ps1) %% '
RPROMPT="%F{${COLOUR_THEME}}%B%~/%b%k%f"

# Alias
alias ls='ls --color=auto'
alias grep='grep --color=auto'
