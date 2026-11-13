---
name: pickup
description: List the latest handoff documents for the current working directory and read the one the user selects so the work from a previous session can continue.
argument-hint: "Which handoff document should be read?"
disable-model-invocation: true
---

Run `~/.agents/skills/handoff/scripts/handoff.sh list` from the current working directory. It prints the paths of the latest 10 handoff documents for this directory, newest first.

If the user passed arguments or named a handoff document, read the matching one and skip the list.

Otherwise, if nothing was printed, say nothing about handoffs and continue with the user's message.

Otherwise, ask the user which one to read with the AskUserQuestion tool, one option per document labeled with its date, time, and title from its filename, newest first. AskUserQuestion takes at most 4 options, so offer the newest 4; the user can name an older one through "Other". Do not read any of them before the user answers. If the user declines, continue without a handoff.

After reading the selected handoff document:

- Call the Skill tool for the skills listed in its suggested skills section.
- Verify claims in the document against the current code and git history before relying on them.
- Use it as context, and continue its open items when the user asks to continue.
