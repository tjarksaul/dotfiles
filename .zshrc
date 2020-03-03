export ZSH=~/.zsh

# Load all of the config files in ~/oh-my-zsh that end in .zsh
for config_file ($ZSH/lib/*.zsh) source $config_file

for config_file ($ZSH/plugins/*/*.zsh) source $config_file

# Load and run compinit
autoload -U compinit
compinit -i

autoload -U colors && colors
PS1="[%{$fg[red]%}%n%{$reset_color%}@%{$fg[green]%}%m %{$fg[yellow]%}%~%{$reset_color%}] "

autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}" ]] && bindkey "${key[Up]}" up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" down-line-or-beginning-search

export HISTSIZE=10000
export HISTFILESIZE=""

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
