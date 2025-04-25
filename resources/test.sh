#!/bin/bash

git_root="$(git rev-parse --show-toplevel 2>/dev/null)"

"$git_root"/resources/bats/bin/bats "$git_root"/resources/test.bats
