#!/bin/sh
_get_repo() {
  # shellcheck disable=SC2039
  local repo_domain
  repo_domain="$(echo "$1" | awk -F[/:] '{print $4}')"
  echo "$1" | sed -e "s/.*$repo_domain[:/]\(.*\)/\1/"
}

_build_url() {
  # shellcheck disable=SC2039
  local upstream origin branch repo pr_url target
  upstream="$(git config --get remote.upstream.url)"
  origin="$(git config --get remote.origin.url | sed -e "s/.git$//")"
  branch="$(git symbolic-ref --short HEAD)"
  repo="$(_get_repo "$origin")"
  pr_url="$origin/pull/new"
  target="$1"
  test -z "$target" && target=$(git for-each-ref --format='%(upstream:short)' "$(git symbolic-ref -q HEAD)" | cut -d '/' -f 2)
  test -z "$target" && target="master"
  if [ -z "$upstream" ]; then
    echo "$pr_url/$target...$branch"
  else
    # shellcheck disable=SC2039
    local origin_name upstream_name
    origin_name="$(echo "$repo" | cut -f1 -d'/')"
    upstream_name="$(_get_repo "$upstream" | cut -f1 -d'/')"
    echo "$pr_url/$upstream_name:$target...$origin_name:$branch"
  fi
}

# shellcheck disable=SC2039
open-pr() {
  # shellcheck disable=SC2039
  local url
  url="$(_build_url "$*")"
  if [ "$(uname -s)" = "Darwin" ]; then
    open "$url" 2> /dev/null
  else
    xdg-open "$url" > /dev/null 2> /dev/null
  fi
}
