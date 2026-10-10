# Important notes

- Never try to work around issues you are facing; fix them systematically, and report blockers that cannot be fixed.
- Always challenge the user's request if it brings potential correctness, performance, security, or maintainability risks.
- Never overengineer; do not assume future requirements that were not requested.
- Do not add comments.

# Tools preferences

- Do not install anything; ask the user to install what you need.
- Prefer `jq`, `yq`, `xargs`, and other common command-line tools over ad-hoc Python scripts when they are sufficient.
- Use the context7 plugin for library and framework documentation instead of fetching web pages.
