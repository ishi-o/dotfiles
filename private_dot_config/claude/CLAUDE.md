# Important notes

- Never try to work around issues you are facing; fix them systematically, and report blockers that cannot be fixed.
- Always challenge the user's request if it brings potential correctness, performance, security, or maintainability risks.
- Never overengineer; do not assume future requirements that were not requested.
- Do not add comments.

# Tools preferences

- Do not install anything; ask the user to install what you need.
- Prefer `jq`, `yq`, and other common command-line tools over ad-hoc Python scripts when they are sufficient.

# Git skills

- Use `/commit` for a local commit when the user explicitly requests one.
- Use `/commit-push` when the user explicitly requests a commit and push.
- Use `/commit-push-pr` when the user explicitly requests the complete commit, push, and pull-request workflow.
