#!/bin/zsh
set -eo pipefail

_get_repo() {
  echo "$1" | sed -e "s/.*github.com[:/]\(.*\)\.git.*/\1/"
}

open-pr() {
  local upstream=$(git config --get remote.upstream.url)
  local origin=$(git config --get remote.origin.url)
  local branch=$(git symbolic-ref --short HEAD)
  local repo=$(_get_repo "$origin")
  local pr_url="https://github.com/$repo/pull/new"
  local target=$( [[ -z "$1" ]] && echo "master" || echo "$1" )
  if [[ -z $upstream ]]; then
    local url="$pr_url/$target...$branch"
  else
    local origin_name=$(echo "$repo" | cut -f1 -d'/')
    local upstream_name=$(_get_repo "$upstream" | cut -f1 -d'/')
    local url="$pr_url/$upstream_name:$target...$origin_name:$branch"
  fi
  open "$url" 2> /dev/null || xdg-open "$url" &> /dev/null
}
