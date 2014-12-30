#!/bin/bash
[[ ! -f "assert.sh" ]] && \
  wget https://raw.githubusercontent.com/lehmannro/assert.sh/master/assert.sh \
  &> /dev/null
source ./assert.sh
source ./open-pr.plugin.zsh
