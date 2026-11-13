---
name: handoff
description: Compact the current conversation into a handoff document for another agent to pick up.
argument-hint: "What will the next session be used for?"
disable-model-invocation: true
---

Write a handoff document summarising the current conversation so a fresh agent can continue the work. Save to `~/Documents/Notes/Handoff`, inside a subdirectory that mirrors the current working directory's path relative to `~` (for example, `~/Documents` saves to `~/Documents/Notes/Handoff/Documents`, and `~` saves directly to `~/Documents/Notes/Handoff`). Create the subdirectory if it does not exist. Name the file `YYYY-MM-DD-HHMM-<short-kebab-case-title>.md` using the current local date and 24-hour time (for example, `2026-11-13-1430-fix-login-bug.md`). If `~/Documents/Notes/Handoff` is not available, save to the temporary directory of the user's OS (`$TMPDIR`, else `/tmp`; `%TEMP%` on Windows) - not the current workspace.

Include a "suggested skills" section in the document, naming which skills the next agent should call the Skill tool for.

Do not duplicate content already captured in other artifacts (specs, plans, ADRs, issues, commits, diffs). Reference them by path or URL instead.

Redact any sensitive information, such as API keys, passwords, or personally identifiable information.

If the user passed arguments, treat them as a description of what the next session will focus on and tailor the doc accordingly.
