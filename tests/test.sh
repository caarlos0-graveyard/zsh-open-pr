#!/bin/bash
echo -e "\nRunning tests..."
find ./tests -name '*-test.sh' | while read -r test; do
  bash "$test"
done
