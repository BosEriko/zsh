---
name: git-commit
description: Create Git commits for completed code changes using the Gitmoji convention. Use when the user explicitly asks to commit changes or approves a proposed commit.
---

# Git Commit

## Workflow

1. Review the current changes.
2. Identify changes belonging to the completed task.
3. Exclude unrelated changes.
4. Choose the most appropriate Gitmoji.
5. Create a concise imperative commit message.
6. Create the commit.
7. Show the resulting commit.

## Rules

- Never commit without explicit user approval.
- Commit only changes related to the requested work.
- Do not amend, squash, rebase, or force-push unless explicitly requested.
- Do not include unrelated working-tree changes.

## Examples

- `✨ Add user authentication flow`
- `🐛 Fix subscription status validation`
- `♻️ Refactor payment service`
- `📝 Update API documentation`
- `🧪 Add tests for deposit orders`
