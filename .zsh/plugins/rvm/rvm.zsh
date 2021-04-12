# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
if [ -d $HOME/.rvm/bin ] && [[ ! "$PATH" == */.rvm/bin* ]]; then
    export PATH="$PATH:$HOME/.rvm/bin"
fi