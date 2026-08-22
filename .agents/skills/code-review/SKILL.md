---
name: code-review
description: Review completed code changes for correctness, regressions, unnecessary complexity, scope violations, and maintainability. Use after implementation and testing before declaring a development task complete.
---

# Code Review

## Workflow

1. Review the complete diff.
2. Compare the changes with the implementation plan.
3. Check for correctness issues.
4. Check edge cases and error paths affected by the changes.
5. Check for regressions to existing behavior.
6. Look for unnecessary changes or scope creep.
7. Check whether existing repository patterns were followed.
8. Check for unnecessary abstractions, duplication, or complexity introduced by the change.
9. Check whether tests adequately cover the changed behavior.
10. Fix issues introduced by the implementation when appropriate.
11. Re-run affected tests after review fixes.

## Review Priorities

Prioritize:

1. Correctness
2. Data loss or destructive behavior
3. Security
4. Regressions
5. Missing requirements
6. Error handling
7. Maintainability
8. Style

## Rules

- Review the actual diff, not just the intended implementation.
- Focus primarily on issues introduced by the current changes.
- Do not turn review into unrelated refactoring.
- Do not change behavior merely because another approach is preferable.
- Report unresolved concerns clearly.
- If review changes the implementation, ensure affected validation is run again.
