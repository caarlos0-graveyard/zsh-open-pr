#!/bin/bash
# shellcheck disable=1091
source "./tests/test-helper.sh"
_mktemp() {
  mktemp -dt fake-repo.XXXXXXXXXX
}

init_repo() {
  local dir="$1"
  cd "$dir" || exit 1
  git init &> /dev/null
  git remote add origin git@github.com:invalid-user/invalid-repo.git
  git checkout -b feat &> /dev/null
}

add_upstream() {
  local dir="$1"
  cd "$dir" || exit 1
  git remote add upstream git@github.com:upstream-invalid-user/invalid-repo.git
}

# only origin, PR to master
dir=$(_mktemp)
init_repo "$dir"
cd "$dir" || exit 1
assert "_build_url" \
  "https://github.com/invalid-user/invalid-repo/pull/new/master...feat"
rm -rf "$dir"

# only origin, PR to blah
dir=$(_mktemp)
init_repo "$dir"
cd "$dir" || exit 1
assert "_build_url blah" \
  "https://github.com/invalid-user/invalid-repo/pull/new/blah...feat"
rm -rf "$dir"

# origin and upstream, PR to master
dir=$(_mktemp)
init_repo "$dir"
add_upstream "$dir"
cd "$dir" || exit 1
assert "_build_url" \
  "https://github.com/invalid-user/invalid-repo/pull/new/upstream-invalid-user:master...invalid-user:feat"
rm -rf "$dir"

# origin and upstream, PR to blah
dir=$(_mktemp)
init_repo "$dir"
add_upstream "$dir"
cd "$dir" || exit 1
assert "_build_url blah" \
  "https://github.com/invalid-user/invalid-repo/pull/new/upstream-invalid-user:blah...invalid-user:feat"
rm -rf "$dir"

assert_end "_build_url()"
