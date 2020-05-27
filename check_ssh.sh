#!/bin/bash -e 

OPTIND=1

print=1
while getopts "p" opt; do
  case "$opt" in
  p) print=0
    ;;
  esac
done

shift $((OPTIND-1))

[ -f ~/.ssh/authorized_keys ] || exit 0

keys=$(grep ssh-rsa ~/.ssh/authorized_keys)
key_count=$(echo $keys | wc -l)

if (($key_count > 0)); then
  echo -n "WARNING! You have at least one ssh authorized key that is using rsa."
  if [ $print -eq 0 ]; then
    echo ""
    printf "%s\n" "$keys" | while IFS= read -r key; do 
      key_name=$(echo $key | awk '{ print $3 }')
      key_name=$(echo -e "${key_name}" | tr -d '[:space:]')
      if [ -z $key_name ]; then
        key_name="UNNAMED"
      fi
      echo $key_name
    done
  else 
    echo " Run $0 -p to print them."
  fi
fi
