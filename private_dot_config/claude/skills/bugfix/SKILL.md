---
name: bugfix
description: Fix bugs using TDD. Use when the user reports a bug or defect.
---

# Bugfix

Fix bugs with TDD:

1. Write a test that reproduces the reported bug first. It must fail.
2. If it passes, the reproduction is wrong. The reported bug may not exist. Rewrite the test, and reason about the code to find the fault. If there is no real defect, say so instead of forcing a fix.
3. Fix the bug.
4. Run the original test to verify it now passes.

Test placement:

- If the project already has a test framework and conventions, add the test there and follow them.
- Otherwise, write and run the test under `/tmp`.

Prefer a unit test over an end-to-end test. Skip the test only when the project is genuinely hard or impossible to test, such as when it needs a GUI or media assets that cannot be faked, or when reproducing the bug would require a very long end-to-end test. If you skip it, say so.
