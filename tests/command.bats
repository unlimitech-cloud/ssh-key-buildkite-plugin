#!/usr/bin/env bats

setup() {
  load "${BATS_PLUGIN_PATH}/load.bash"

  # Uncomment to enable stub debugging
  # export CURL_STUB_DEBUG=/dev/tty
  export DRY_RUN='true'
}

@test "Running without arguments succeeds" {
  run "${PWD}/hooks/checkout"

  assert_success
  assert_output --partial 'Running SSH Checkout plugin'
}

@test "Normal basic operations" {
  run "${PWD}/hooks/checkout"

  assert_success
  assert_output --partial 'Running SSH Checkout plugin with options'
  assert_output --partial '- repository-url: '
}

@test "Optional value changes bejaviour" {
  export BUILDKITE_PLUGIN_GIT_SSH_CHECKOUT_REPOSITORY_URL='git@example.com:org/repo.git'
  export BUILDKITE_PLUGIN_GIT_SSH_CHECKOUT_SSH_SECRET_KEY_NAME='SUPER_SECRET_KEY'

  run "${PWD}/hooks/checkout"

  assert_success
  assert_output --partial 'Running SSH Checkout plugin with options'
  assert_output --partial '- ssh-secret-key-name: SUPER_SECRET_KEY'
}
