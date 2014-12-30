#!/bin/bash
source ./build/build.sh

echo -e "\nRunning tests..."
find ./tests -name '*-test.sh' | while read test; do
  bash "$test"
done
