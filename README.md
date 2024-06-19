# Git SSH Checkout

A Buildkite plugin for arbitrary Git SSH checkout.

**This plugin is only relevant in a Hosted Agent context.** The cluster secrets functionality is utilised for storing the SSH key, which is only available with the hosted agents.

## Options

### Optional

#### `repository-url` (string)

The full URL for referencing the repository. This is typically in the form of `git@{hostname}:{organisation}/{repository}.git`.

By default, the value for this will be the value of the `BUILDKITE_REPO` environment variable.

#### `ssh-secret-key-name` (string)

The name of the [secrets](https://buildkite.com/docs/agent/v3/cli-secret) key that contains the SSH key for interacting with the Git repository.

By default, the key name is `GIT_SSH_CHECKOUT_PLUGIN_SSH_KEY`.

#### `checkout-path` (string)

Replace the path the repository will be checked out to.

By default, the path will be `.`, the base path for the current build.

## Examples

Making use of the default values:

```yaml
steps:
  - label: "🔨 Running build"
    command: "echo Build happens here 💪"
    plugins:
      - git-ssh-checkout#v1.0.0:
```

### Overriding specific attributes

Specifying options that differ from the defaults:

```yaml
steps:
  - label: "🔨 Running build"
    command: "echo Build happens here 💪"
    plugins:
      - git-ssh-checkout#v1.0.0:
          repository-url: "git@example.com:org/repo.git"
          ssh-secret-key-name: "SUPER_SECRET_KEY"
```

### Using multiple repositories and keys

```yaml
steps:
  - label: "🔨 Running build A"
    command: "echo Build happening 🅰"
    plugins:
      - git-ssh-checkout#v1.0.0:
          repository-url: "git@example.com:org/repo-a.git"
          ssh-secret-key-name: "REPO_A_SECRET_KEY"
  - label: "🔨 Running build B"
    command: "echo Build happening 🅱"
    plugins:
      - git-ssh-checkout#v1.0.0:
          repository-url: "git@example.com:org/repo-b.git"
          ssh-secret-key-name: "REPO_B_SECRET_KEY"
```

## ⚒ Developing

You can use the [bk cli](https://github.com/buildkite/cli) to run the [pipeline](.buildkite/pipeline.yml) locally:

```bash
bk local run
```

## 👩‍💻 Contributing

1. Fork the repo.
2. Make the changes.
3. Run the tests.
4. Commit and push your changes.
5. Send a pull request.

## 📜 License

MIT (see [LICENSE](./LICENSE)).
