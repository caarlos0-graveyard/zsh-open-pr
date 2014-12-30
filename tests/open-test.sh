#!/bin/bash
source "./tests/test-helper.sh"
setup() {
  uname_value="$1"
  open() {
    exit 0
  }
  xdg-open() {
    exit 0
  }
  uname() {
    echo "$uname_value"
  }
  assert "uname -s" "$1"
}

# tests open on osx
setup "Darwin"
assert "_open on-osx"

# test open on linux
setup "Linux"
assert "_open on-linux"

unset -f uname
unset -f open
unset -f xdg-open

assert_end "_open()"
