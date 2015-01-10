#!/bin/zsh

_get_repo() {
  # shellcheck disable=SC2001
  echo "$1" | sed -e "s/.*github.com[:/]\(.*\)\.git.*/\1/"
}

_open() {
  if [ "$(uname -s)" = "Darwin" ]; then
    open "$1" 2> /dev/null
  else
    xdg-open "$1" &> /dev/null
  fi
}

_build_url() {
  local upstream=$(git config --get remote.upstream.url)
  local origin=$(git config --get remote.origin.url)
  local branch=$(git symbolic-ref --short HEAD)
  local repo=$(_get_repo "$origin")
  local pr_url="https://github.com/$repo/pull/new"
  local target=$( [[ -z "$1" ]] && echo "master" || echo "$1" )
  if [[ -z $upstream ]]; then
    echo "$pr_url/$target...$branch"
  else
    local origin_name=$(echo "$repo" | cut -f1 -d'/')
    local upstream_name=$(_get_repo "$upstream" | cut -f1 -d'/')
    echo "$pr_url/$upstream_name:$target...$origin_name:$branch"
  fi
}

open-pr() {
  local url=$(_build_url "$*")
  _open "$url"
}
