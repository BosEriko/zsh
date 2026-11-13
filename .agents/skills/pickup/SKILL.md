---
name: pickup
description: Read the latest handoff document for the current working directory so the work from a previous session can continue.
argument-hint: "Which handoff document should be read?"
---

Find the handoff subdirectory for the current working directory: the subdirectory of `~/Documents/Notes/Handoff` that mirrors the working directory's path relative to `~` (for example, `~/Documents` uses `~/Documents/Notes/Handoff/Documents`, and `~` uses `~/Documents/Notes/Handoff`). If it does not exist or has no handoff documents directly inside it, stop and continue without a handoff.

Handoff filenames start with a `YYYY-MM-DD-HHMM` local date and 24-hour time (for example, `2026-11-13-1430-fix-login-bug.md`). Read the handoff document directly inside that subdirectory with the latest date and time in its filename, not the latest modification time. Ignore the subdirectories of other projects nested below it.

If the user passed arguments or named another handoff document in that subdirectory, read that one instead.

Call the Skill tool for the skills listed in its suggested skills section.

Verify claims in the document against the current code and git history before relying on them.

Use it as context for the user's message, and continue its open items when the user asks to continue.
