---
name: git-commit
description: Create Git commits for completed code changes using the Gitmoji convention. Use when the user explicitly asks to commit changes or approves a proposed commit.
---

# Git Commit

## Workflow

1. Review the changes that will be committed.
2. Verify that only changes related to the completed implementation step are included.
3. Choose the Gitmoji that best represents the change.
4. Create a concise commit message.
5. Create the Git commit.
6. Show the commit that was created.

## Rules

- Never commit without explicit user confirmation.
- Use the Gitmoji convention for commit messages.
- Use a concise imperative commit message.
- Commit only changes related to the current implementation step.
- Do not include unrelated changes.
- Do not amend, squash, rebase, or force-push unless explicitly requested.

## Examples

- `✨ Add user authentication flow`
- `🐛 Fix subscription status validation`
- `♻️ Refactor payment service`
- `📝 Update API documentation`
- `🧪 Add tests for deposit orders`
