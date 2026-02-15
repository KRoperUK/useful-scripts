# Contributing to useful-scripts

Thank you for your interest in contributing! To ensure a smooth release process, we follow certain conventions.

## Conventional Commits

We use [Conventional Commits](https://www.conventionalcommits.org/) for automated releases. This means your Pull Request titles MUST follow this format:

- `feat: ...` for new features
- `fix: ...` for bug fixes
- `docs: ...` for documentation changes
- `chore: ...` for maintenance
- `ci: ...` for CI/CD changes

## Repository Settings (For Admins)

To ensure the best experience with `release-please`, the following settings are recommended in GitHub:

1.  Go to **Settings** > **General** > **Pull Requests**.
2.  Under **Allow squash merging**, select **Default squash commit message**.
3.  Choose **Pull request title**.

This ensures that when a PR is merged, the PR title (which is linted) becomes the commit message on `main`.

## Development Flow

1.  Create a feature branch.
2.  Use `pre-commit` to ensure code quality.
3.  Use the `auto-commit` tool to generate compliant commit messages.
4.  Open a Pull Request with a conventional title.
5.  Wait for CI checks (Lint, PR Title Lint) to pass.
