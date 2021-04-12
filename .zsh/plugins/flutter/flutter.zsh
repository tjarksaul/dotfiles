if [ -d ~/dev/flutter ] && [[ ! "$PATH" == */dev/flutter/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$HOME/dev/flutter/bin"
fi

