# useful-scripts

[![Lint](https://github.com/KRoperUK/useful-scripts/actions/workflows/lint.yaml/badge.svg)](https://github.com/KRoperUK/useful-scripts/actions/workflows/lint.yaml)
[![release-please](https://github.com/KRoperUK/useful-scripts/actions/workflows/release.yaml/badge.svg)](https://github.com/KRoperUK/useful-scripts/actions/workflows/release.yaml)
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

2.  Add the script to your `~/.zshrc` by sourcing it:
    ```bash
    # Source the auto-commit script
    source ~/gitProjects/useful-scripts/bash/auto-commit.sh
    ```

3.  Reload your shell configuration:
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

## Development

This repository uses `pre-commit` to ensure code quality, including checking for trailing whitespace, YAML validation, and shell script analysis with `shellcheck` and `shfmt`.

To set up the pre-commit hooks locally:

1.  Install pre-commit (e.g., via pip or brew).
2.  Run `pre-commit install` in the repository root.
