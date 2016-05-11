alias ll='ls -la'
alias lh='ls -lah'
alias ...='cd ../..'
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
alias vinfo='mplayer -vo null -ao null -identify -frames 0'
alias gut='git'

function mcd() {
    mkdir $1 && cd $1
}
