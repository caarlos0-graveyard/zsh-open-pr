#!/bin/bash
# shellcheck disable=1091
source "./tests/test-helper.sh"

assert "_get_repo git@github.com:caarlos0/zsh-open-pr.git" \
  "caarlos0/zsh-open-pr"
assert "_get_repo https://github.com/caarlos0/zsh-open-pr.git" \
  "caarlos0/zsh-open-pr"

# for #8:
assert "_get_repo git@github.com:caarlos0/zsh-open-pr" \
  "caarlos0/zsh-open-pr"
assert "_get_repo https://github.com/caarlos0/zsh-open-pr" \
  "caarlos0/zsh-open-pr"

assert_end "_get_repo()"
