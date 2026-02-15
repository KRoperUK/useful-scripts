# useful-scripts

[![Lint](https://github.com/KRoperUK/useful-scripts/actions/workflows/lint.yaml/badge.svg)](https://github.com/KRoperUK/useful-scripts/actions/workflows/lint.yaml)
[![release-please](https://github.com/KRoperUK/useful-scripts/actions/workflows/release.yaml/badge.svg)](https://github.com/KRoperUK/useful-scripts/actions/workflows/release.yaml)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/KRoperUK/useful-scripts)](https://github.com/KRoperUK/useful-scripts/releases)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)
[![Renovate](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://renovatebot.com/)

Various useful scripts.

## Installation & Usage

You can add these scripts to your shell configuration (e.g., `.zshrc`) in a few ways.

### Option 1: Clone and Source (Recommended)

1.  Clone the repository to a location of your choice (e.g., `~/gitProjects/useful-scripts`):
    ```bash
    git clone https://github.com/KRoperUK/useful-scripts.git ~/gitProjects/useful-scripts
    ```

2.  (Recommended) Switch to the latest stable release:
    ```bash
    cd ~/gitProjects/useful-scripts && git checkout $(git describe --tags --abbrev=0)
    ```

3.  Add the script to your `~/.zshrc` by sourcing it:
    ```bash
    # Source the auto-commit script
    source ~/gitProjects/useful-scripts/bash/auto-commit.sh
    ```

4.  Reload your shell configuration:
    ```bash
    source ~/.zshrc
    ```

#### Configuration (`auto-commit`)

The `auto-commit` script can be customized via environment variables in your `.zshrc`:

- `AUTO_COMMIT_OPENAI_API_KEY`: Your API key (OpenRouter or OpenAI-compatible). Fallback: `OPENROUTER_API_KEY`.
- `AUTO_COMMIT_OPENAI_BASEURL`: The API base URL. Defaults to `https://openrouter.ai/api/v1`.
- `AUTO_COMMIT_MODEL`: The model name to use. Defaults to `anthropic/claude-3.5-haiku`.
- `AUTO_COMMIT_MAX_TOKENS`: Maximum tokens for the response. Defaults to `300`.
- `AUTO_COMMIT_INSTRUCTIONS`: Extra instructions for the AI (e.g., "Always include JIRA ticket JIRA-123").

**Example:**
```bash
export AUTO_COMMIT_OPENAI_API_KEY="your-key-here"
export AUTO_COMMIT_INSTRUCTIONS="Include JIRA-123 in the scope if relevant"
```

### Option 2: Manual Copy

If you prefer not to clone the repository, you can copy the content of a script (e.g., `bash/auto-commit.sh`) and paste it directly into your `~/.zshrc` file.

## CI/CD & Releases

This project uses **release-please** to automate versioning and changelogs.

- **Automated Releases**: When you merge a PR with conventional commit messages to `main`, a "Release PR" will be automatically created/updated. Merging that PR will create a new GitHub release and tag.
- **Conventional Commits**: Ensure your PR titles or commit messages follow the [Conventional Commits](https://www.conventionalcommits.org/) format (e.g., `feat: message`, `fix: message`).

### Troubleshooting `release-please`

If `release-please` fails to parse a commit (e.g., `Error: unexpected token...`), it won't trigger a new release.

**Fix**:
1. Check your PR titles on GitHub. If they look like `Feat/branch-name`, they will fail.
2. To "kick" the release process, you can push an empty commit with a correct message:
   ```bash
   git commit --allow-empty -m "chore: trigger release"
   git push
   ```

**Pro Tip**: Always use **Squash and Merge** on GitHub and ensure the PR title follows `feat: ...` or `fix: ...` format.

## Development

This repository uses `pre-commit` to ensure code quality.

To set up the pre-commit hooks locally:

1.  Install pre-commit (e.g., via pip or brew).
2.  Run `pre-commit install` in the repository root.

The hooks include:
- `trailing-whitespace`, `end-of-file-fixer`, `check-yaml`, `check-added-large-files`
- `no-commit-to-branch` (prevents direct commits to `main`)
- `conventional-pre-commit` (enforces conventional commit messages)
- `shellcheck` and `shfmt` (for shell scripts)
