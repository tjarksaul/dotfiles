alias ll='ls -la'
alias lh='ls -lah'
alias ...='cd ../..'
alias vinfo='mplayer -vo null -ao null -identify -frames 0'
alias gut='git'
alias fire='git commit -am "BURNING DOWN" && git push -f origin master'
alias kc='kubectl'
alias gst='git status'
alias gp='git pull'
alias gpu='git push'
alias gc='git commit'
alias gl='git log -n 10 --pretty=format:"%C(auto) %h %s %d"'

function mcd() {
    mkdir $1 && cd $1
}

transfer() { if [ $# -eq 0 ]; then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi
tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }

gupdate() {
    OLDBRANCH=`git branch | grep \* | cut -d ' ' -f2`
    BRANCH=${1:-"master"}
    (
        set -e
        git checkout $BRANCH
        git pull
        git branch -d $OLDBRANCH
    )
}

git-featurebranch() {
    echo -n "Branch-Name? "
    read BRANCH
    echo -n "Commit-Message? " 
    read COMMIT
    git show-ref --verify --quiet refs/heads/$BRANCH
    if [ $? -eq 0 ]; then 
        echo -n "Branch mit dem Namen $BRANCH existiert. LÃschen? [yN] " 
        read DEL
        case $DEL in
            [Yy]* ) git branch -D $BRANCH;;
            * ) return;;
        esac
    fi
    git checkout -b $BRANCH
    git commit -m $COMMIT
}

cgr() {
    git_root=$(git rev-parse --show-toplevel)
    cd $git_root
}

