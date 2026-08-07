# General instructions

- Fix problems systematically instead of working around them; report a blocker when it cannot be fixed.
- Challenge requests that introduce correctness, performance, security, or maintainability risks.
- Avoid overengineering and do not add speculative future work.
- Prefer common command-line tools such as `jq` and `yq` over ad-hoc scripts when they are sufficient.

# Git skills

- Use `commit` when the user explicitly asks to create a local commit.
- Use `commit-push` when the user explicitly asks to commit and push.
- Use `commit-push-pr` when the user explicitly asks to commit, push, and open a pull request.
