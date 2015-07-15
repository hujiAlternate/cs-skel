#!/bin/bash

# If not running interactively
[ -z "$PS1" ] && return

# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

bind "set completion-ignore-case on"
bind '"\e[B": history-search-forward'
bind '"\e[A": history-search-backward'

# default permissions of newly created files and directories
# - deny all others directory-access, read and write permissions
umask 077

#set bash theme
PS1="\n\[\033[1;37m\]\342\224\214($(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[01;36m\]\u@\h'; fi)\[\033[1;37m\])\342\224\200(\$(if [[ \$? == 0 ]]; then echo \"\[\033[01;32m\]\342\234\223\"; else echo \"\[\033[01;31m\]\342\234\227\"; fi)\[\033[1;37m\])\342\224\200(\[\033[1;36m\]\@ \d\[\033[1;37m\])\[\033[1;37m\]\n\342\224\224\342\224\200(\[\033[1;32m\]\w\[\033[1;37m\])\342\224\200(\[\033[1;32m\]\$(ls -1 | wc -l | sed 's: ::g') files, \$(ls -lah | grep -m 1 total | sed 's/total //')b\[\033[1;37m\])\342\224\200> \[\033[0m\]"

# Fancy aliases
if (-e ~/.aliases) source ~/.aliases

# Show a fortune cookie
if [ -x /usr/games/fortune ]; then
   echo -e "\e[00;33m$(/usr/games/fortune)\e[00m"
fi

