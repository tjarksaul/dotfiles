PATH=/sbin:$PATH
PATH=/usr/bin:/usr/sbin:$PATH
PATH=/usr/local/bin:$PATH
PATH=/usr/local/bin:/usr/local/sbin:$PATH
PATH=$HOME/bin:$PATH

export GOPATH=$HOME/go
PATH=$PATH:$GOPATH/bin

fpath=($HOME/.zsh/completion $fpath)
