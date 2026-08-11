---
name: commit
description: Create one git commit from the current changes. Use when the user explicitly asks to commit changes locally.
---

# Create a commit

Before acting, inspect the current repository:

- Run `git status`.
- Review the complete staged and unstaged diff with `git diff HEAD`.
- Check the current branch with `git branch --show-current`.
- Review recent commit messages with `git log --oneline -10`.

Create a single commit containing only the changes relevant to the user's request. Choose a concise,
imperative commit message that describes the change. Do not push or create a pull request unless the
user separately requests it.
