extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

function github() {
  local github_url
 
  if ! git remote -v >/dev/null; then
    return 1
  fi
 
  # get remotes for fetch
  github_url="`git remote -v | grep github\.com | grep \(fetch\)$`"
 
  if [ -z "$github_url" ]; then
    echo "A GitHub remote was not found for this repository."
    return 1
  fi
 
  # look for origin in remotes, use that if found, otherwise use first result
  if [ "echo $github_url | grep '^origin' >/dev/null 2>&1" ]; then
    github_url="`echo $github_url | grep '^origin'`"
  else
    github_url="`echo $github_url | head -n1`"
  fi
 
  github_url="`echo $github_url | awk '{ print $2 }' | sed 's/git@github\.com:/http:\/\/github\.com\//g'`"
  echo $github_url
}

function run-if-available() {
  which $1 > /dev/null 2>&1 && $@ || true
}

function weather() {
  which wego 2>&1 > /dev/null || return 0
  which locateme 2>&1 > /dev/null && eval "local LOC=(-l $(locateme -f "{LAT},{LON}"))"
  wego ${LOC} 0
}

function check_dotfiles_status() {
  dir=$(pwd)
  cd $HOME/dotfiles
  RED='\033[0;31m'
  NC='\033[0m'   
  [ -n "$(git status --porcelain)" ] \
    && echo "### ${RED}UNCOMMITED CHANGES${NC} ###\nThere are uncommited changes in your dotfiles directory. Please check!"
  cd $dir
}

git () {
    if [ "$1" = "checkout" ]
    then
        echo "Don't use checkout; use switch or restore." >&2
        return 1
    else
        command git "$@"
    fi
}

