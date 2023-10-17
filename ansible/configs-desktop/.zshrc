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

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%F{green}%n%f in %F{cyan}${PWD/#$HOME/~}%f %F{red}${vcs_info_msg_0_}%f
> '

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats 'on %b'

alias la='ls -Alhp'