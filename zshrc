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

# Git prompt for Arch
if [ -e '/usr/share/git/completion/git-prompt.sh' ]
then
    source /usr/share/git/completion/git-prompt.sh
fi

# Git prompt for Debian
if [ -e '/usr/lib/git-core/git-sh-prompt' ]
then
    source /usr/lib/git-core/git-sh-prompt
fi

# Fix the Git pager
export LESSCHARSET="utf-8"

# Red is a snep colour :3
COLOUR_THEME=red

PROMPT='%F{${COLOUR_THEME}}%B%K{${COLOUR_THEME}} %F{white}%K{${COLOUR_THEME}}%B%n@%m%b%F{${COLOUR_THEME}}%k█▓▒%b%k%f$(__git_ps1) %% '
RPROMPT="%F{${COLOUR_THEME}}%B%~/%b%k%f"

# Alias
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias vi='vim'
