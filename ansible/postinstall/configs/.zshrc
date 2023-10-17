# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/sam/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#PROMPT='%F{green}%n%f in %F{cyan}%~%f %# '

# Color settings:
# %F{colorname}...%f
# Bolding:
# %B...%b

# Set up the prompt (with git branch name)
#setopt PROMPT_SUBST

PROMPT='@%F{green}%m%f in %F{cyan}${PWD/#$HOME/~}%f %F{red}${vcs_info_msg_0_}%f
$ '

# Load version control information
#autoload -Uz vcs_info
#precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
#zstyle ':vcs_info:git:*' formats 'on %b'

# Autoload zsh add-zsh-hook and vcs_info functions (-U autoload w/o substition, -z use zsh style)
autoload -Uz add-zsh-hook vcs_info
# Enable substitution in the prompt.
setopt prompt_subst
# Run vcs_info just before a prompt is displayed (precmd)
add-zsh-hook precmd vcs_info

# add ${vcs_info_msg_0} to the prompt
# e.g. here we add the Git information in red
#PROMPT='%1~ %F{red}${vcs_info_msg_0_}%f %# '

# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' check-for-changes true
# Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
zstyle ':vcs_info:*' unstagedstr ' ***'
zstyle ':vcs_info:*' stagedstr ' +++'
# Set the format of the Git information for vcs_info
zstyle ':vcs_info:git:*' formats       '(%b%u%c)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'

# Aliases
alias ..='cd ..'
alias la='ls -lAhp --group-directories-first --color=auto'
alias lar='la -R'
alias docker='sudo docker'
alias docker-compose='sudo docker-compose'
alias ip='ip --color'
alias tree='tree -CF --dirsfirst'
