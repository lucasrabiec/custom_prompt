#!/bin/bash

COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_BLUE="\033[0;34m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"
COLOR_CYAN="\033[0;36m"
COLOR_MAGENTA="\033[0;35m"

function git_color {
  local git_status="$(git status 2> /dev/null)"

  if [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e $COLOR_YELLOW
  elif [[ $git_status =~ "Your branch is behind" ]]; then
    echo -e $COLOR_YELLOW
  elif [[ $git_status =~ "working tree clean" ]]; then
    echo -e $COLOR_GREEN
  elif [[ ! $git_status =~ "working tree clean" ]]; then
    echo -e $COLOR_RED
  fi
}

function git_symbol {
  local git_status="$(git status 2> /dev/null)"

  if [[ $git_status =~ "Your branch is behind" ]]; then
    echo "▼"
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo "▲"
  elif [[ $git_status =~ "working tree clean" ]]; then
    echo "✔"
  elif [[ ! $git_status =~ "working tree clean" ]]; then
    echo "✘"
  fi
}

function git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "(git: ${ref#refs/heads/} $(git_symbol))"
}

PS1="\[$COLOR_CYAN\]\u@\h\[$COLOR_RESET\]:\[$COLOR_MAGENTA\]\w "
PS1+="\[\$(git_color)\]"
PS1+="\$(git_branch)"
PS1+="\n\[$COLOR_BLUE\]\$\[$COLOR_RESET\] "
export PS1
