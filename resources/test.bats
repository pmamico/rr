#!/usr/bin/env bats

setup() {
    load "$(git rev-parse --show-toplevel 2>/dev/null)/resources/test_helper/bats-support/load"
    load "$(git rev-parse --show-toplevel 2>/dev/null)/resources/test_helper/bats-assert/load"

    DIR="$(git rev-parse --show-toplevel 2>/dev/null)"
    PATH="$DIR:$PATH"
}


@test "rr --help" {
    run rr --help
    assert_output --partial 'rr v0.1 - the README runner'
}

@test "RR_FILE="hello_world.md" rr " {
  export RR_FILE="resources/hello_world.md"
  run rr

  assert_output --regexp $'^rr 1\necho "Hello World"$'
}

@test "RR_FILE="hello_world.md" rr 1 --dry" {
  export RR_FILE="resources/hello_world.md"
  run rr 1 --dry

  assert_output 'echo "Hello World"'
}


@test "RR_FILE="hello_world.md" rr 1" {
  export RR_FILE="resources/hello_world.md"
  run rr 1

  assert_output "Hello World"
}

@test "RR_FILE="hello_world.md" rr 2 --dry" {
  export RR_FILE="resources/hello_world.md"
  run rr 2

  assert_output "Error: no block number 2 found."
}

@test "RR_FILE="hello_world.md" rr 2" {
  export RR_FILE="resources/hello_world.md"
  run rr 2

  assert_output "Error: no block number 2 found."
}

@test "RR_FILE=\"test_cases.md\" rr" {
  export RR_FILE="resources/test_cases.md"
  run rr

  expected=$(cat <<'EOF'
rr 1 / rr build
echo "build"

rr 2 / rr second block
echo "Second Block"

rr 3
echo "Block without a label"

rr 4
counter=1
while [ "$counter" -le 15 ]; do
  echo "Item $counter"
  counter=$((counter+1))
done
echo "Done"
EOF
)

  assert_output "$expected"
}

@test "RR_FILE="test_cases.md" rr 1 --dry" {
  export RR_FILE="resources/test_cases.md"
  run rr 1 --dry

  assert_output 'echo "build"'
}

@test "RR_FILE="test_cases.md" rr 1" {
  export RR_FILE="resources/test_cases.md"
  run rr 1

  assert_output 'build'
}

@test "RR_FILE="test_cases.md" rr build --dry" {
  export RR_FILE="resources/test_cases.md"
  run rr build --dry

  assert_output 'echo "build"'
}


@test "RR_FILE="test_cases.md" rr build" {
  export RR_FILE="resources/test_cases.md"
  run rr build

  assert_output 'build'
}



@test "RR_FILE="test_cases.md" rr second block --dry" {
  export RR_FILE="resources/test_cases.md"
  run rr second block --dry

  assert_output 'echo "Second Block"'
}

@test "RR_FILE="test_cases.md" rr second block" {
  export RR_FILE="resources/test_cases.md"
  run rr second block

  assert_output 'Second Block'
}

@test "RR_FILE="test_cases.md" rr 3 --dry" {
  export RR_FILE="resources/test_cases.md"
  run rr 3 --dry

  assert_output 'echo "Block without a label"'
}

@test "RR_FILE="test_cases.md" rr 3" {
  export RR_FILE="resources/test_cases.md"
  run rr 3

  assert_output 'Block without a label'
}

@test "RR_FILE="test_cases.md" rr 4 --dry" {
  export RR_FILE="resources/test_cases.md"
  run rr 4 --dry

   expected=$(cat <<'EOF'
counter=1
while [ "$counter" -le 15 ]; do
  echo "Item $counter"
  counter=$((counter+1))
done
echo "Done"
EOF
)

  assert_output "$expected"
}

@test "RR_FILE="test_cases.md" rr 4" {
  export RR_FILE="resources/test_cases.md"
  run rr 4

  assert_output --partial 'Item 1'
  assert_output --partial 'Item 15'
  assert_output --partial 'Done'
}