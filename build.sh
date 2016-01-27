#!/bin/bash
# shellcheck disable=1091
source ./build/build.sh

echo -e "\nRunning tests..."
find ./tests -name '*-test.sh' | while read -r test; do
  bash "$test"
done
