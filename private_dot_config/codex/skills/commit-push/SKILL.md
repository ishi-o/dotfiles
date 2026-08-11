---
name: commit-push
description: Create one git commit and push it to the remote. Use when the user explicitly asks to commit and push changes.
---

# Commit and push

Before acting, inspect the current repository:

- Run `git status`.
- Review the complete staged and unstaged diff with `git diff HEAD`.
- Check the current branch with `git branch --show-current`.

If the current branch is `main`, stop and ask the user for explicit confirmation before proceeding.
Otherwise:

1. Stage only the changes relevant to the user's request.
2. Create one commit with a concise, imperative message.
3. Push the current branch to its configured remote.

Do not create a pull request unless the user separately requests it.
