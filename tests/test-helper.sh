#!/bin/bash
[[ ! -f "assert.sh" ]] && \
  wget https://raw.githubusercontent.com/lehmannro/assert.sh/master/assert.sh \
  &> /dev/null
# shellcheck disable=1091
source assert.sh
# shellcheck disable=1091
source git-open-pr.sh
