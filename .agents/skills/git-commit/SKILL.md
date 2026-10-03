---
name: git-commit
description: Create Git commits for completed code changes using Gitmoji. Use when the user explicitly asks to commit changes or approves a proposed commit.
---

# Git Commit

## Workflow

1. Review changes and exclude unrelated work.
2. Choose the Gitmoji matching the primary intent.
3. Create: `<emoji> <imperative message>`
4. Commit only after explicit approval.
5. Show the resulting commit.

## Gitmoji

✨ feature
🐛 bug fix
🩹 minor fix
🚑 critical hotfix
♻️ refactor
⚡ performance
🎨 code structure/format
🔥 remove code/files
⚰️ dead code
💥 breaking change
📝 documentation
✏️ typo
💬 text/literals
💡 comments
✅ tests
🧪 failing test
📸 snapshots
🚨 lint/compiler warnings
💄 UI/style
🚸 UX
📱 responsive
♿ accessibility
💫 animations
🔒 security
🛂 authorization
🦺 validation
🗃️ database
🌱 seeds
🏷️ types
👔 business logic
🏗️ architecture
🧵 concurrency
🔧 configuration
🔨 dev scripts
👷 CI
💚 fix CI
🧱 infrastructure
🚀 deployment
⬆️ upgrade dependency
⬇️ downgrade dependency
➕ add dependency
➖ remove dependency
📌 pin dependency
👽 external API change
📦 compiled/package files
🚚 move/rename
⏪ revert
🔀 merge
🔖 release
🙈 gitignore
🌐 i18n
🔍 SEO
🍱 assets
📈 analytics
🔊 logs
🔇 remove logs
🩺 healthcheck
🚩 feature flags
🎉 initial commit
👥 contributors
🚧 WIP
🤡 mocks
⚗️ experiments
🥚 easter egg
📄 license
🧑‍💻 developer experience

## Rules

- Never commit without explicit approval.
- Commit only task-related changes.
- Prefer one Gitmoji representing the primary intent.
- Do not amend, squash, rebase, or force-push unless requested.
- Keep messages concise and imperative.
