---
name: quickfix
description: Fix small, low-risk bugs fast. Use only for trivial defects.
---

# Quickfix

Fix small bugs fast, without full TDD verification.

- Skip writing a reproduction test.
- Make the smallest change that fixes the reported behavior.
- Do not refactor, do not touch unrelated code. Small-scope refactoring is allowed only if the user explicitly insists.
- If the fix turns out to be non-trivial or risky, stop and use the `bugfix` skill instead.

Only use this when the defect is trivial and the fix is obviously safe.
