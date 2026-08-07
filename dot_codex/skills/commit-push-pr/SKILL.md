---
name: commit-push-pr
description: Create a branch when needed, commit and push the current changes, then open a GitHub pull request. Use when the user explicitly asks for the complete commit-push-PR workflow.
---

# Commit, push, and open a pull request

Before acting, inspect the current repository:

- Run `git status`.
- Review the complete staged and unstaged diff with `git diff HEAD`.
- Check the current branch with `git branch --show-current`.

If the current branch is `main`, create a descriptive feature or fix branch before committing.
Then:

1. Stage only the changes relevant to the user's request.
2. Create one commit with a concise, imperative message.
3. Push the branch to its remote.
4. Open a pull request with `gh pr create`, including a useful title and summary.

Complete the requested workflow in one coordinated action. Do not perform unrelated cleanup.
