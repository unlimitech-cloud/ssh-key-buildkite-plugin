#!/usr/bin/env bats

setup() {
  load "${BATS_PLUGIN_PATH}/load.bash"

  # Uncomment to enable stub debugging
  # export CURL_STUB_DEBUG=/dev/tty
  export DRY_RUN='true'
  export BUILDKITE_PLUGIN_GIT_SSH_CHECKOUT_REPOSITORY_URL='git@example.com:organisation/repository.git'
}

@test "Running without arguments succeeds" {
  run "${PWD}/hooks/checkout"

  assert_success
  assert_output --partial 'Running SSH Checkout plugin'
  assert_output --partial '- repository-url: git@example.com:organisation/repository.git'
  assert_output --partial '- ssh-secret-key-name: GIT_SSH_CHECKOUT_PLUGIN_SSH_KEY'
  assert_output --partial '- checkout-path: ./'
}

@test "Normal basic operations" {
  export BUILDKITE_PLUGIN_GIT_SSH_CHECKOUT_REPOSITORY_URL='git@example.com:org/repo.git'
  run "${PWD}/hooks/checkout"

  assert_success
  assert_output --partial 'Running SSH Checkout plugin with options'
  assert_output --partial '- repository-url: git@example.com:org/repo.git'
  assert_output --partial '- ssh-secret-key-name: GIT_SSH_CHECKOUT_PLUGIN_SSH_KEY'
  assert_output --partial '- checkout-path: ./'
}

@test "Optional value changes behaviour" {
  export BUILDKITE_PLUGIN_GIT_SSH_CHECKOUT_REPOSITORY_URL='git@example.com:org/repo.git'
  export BUILDKITE_PLUGIN_GIT_SSH_CHECKOUT_SSH_SECRET_KEY_NAME='SUPER_SECRET_KEY'
  export BUILDKITE_PLUGIN_GIT_SSH_CHECKOUT_CHECKOUT_PATH='sub'

  run "${PWD}/hooks/checkout"

  assert_success
  assert_output --partial 'Running SSH Checkout plugin with options'
  assert_output --partial '- repository-url: git@example.com:org/repo.git'
  assert_output --partial '- ssh-secret-key-name: SUPER_SECRET_KEY'
  assert_output --partial '- checkout-path: sub'
}
