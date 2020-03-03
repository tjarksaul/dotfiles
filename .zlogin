PATH=/sbin:$PATH
PATH=/usr/bin:/usr/sbin:$PATH
PATH=/usr/local/bin:$PATH
PATH=/usr/local/bin:/usr/local/sbin:$PATH
PATH=/usr/local/texlive/2014/bin/x86_64-darwin:$PATH
PATH=$HOME/bin:$PATH

export GOPATH=$HOME/go
PATH=$PATH:$GOPATH/bin
#PATH="$(brew --prefix homebrew/php/php56)/bin:$PATH"

fpath=($HOME/.zsh/completion $fpath)

run-if-available neofetch
run-if-available wego 0 
run-if-available fortune

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
