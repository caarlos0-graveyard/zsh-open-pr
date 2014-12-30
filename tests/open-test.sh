#!/bin/bash
source "./tests/test-helper.sh"
setup() {
  uname_value="$1"
  open() {
    if [ "$uname_value" != "Darwin" ]; then
      assert true false
    fi
    exit 0
  }
  xdg-open() {
    if [ "$uname_value" = "Darwin" ]; then
      assert true false
    fi
    exit 0
  }
  uname() {
    echo "$uname_value"
  }
  assert "uname -s" "$1"
}

# tests open on osx
setup "Darwin" "open"
assert "_open on-osx"

# test open on linux
setup "Linux" "xdg-open"
assert "_open on-linux"

unset -f uname
unset -f open
unset -f xdg-open

assert_end "_open()"
