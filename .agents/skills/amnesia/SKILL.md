---
name: amnesia
description: Delete all but the latest 10 handoff documents for the current working directory.
disable-model-invocation: true
---

Run `~/.agents/skills/handoff/scripts/handoff.sh prune` from the current working directory. It keeps the latest 10 handoff documents for this directory, deletes the rest, and prints the paths it deleted.

Report which handoff documents were deleted, or that nothing was deleted if nothing was printed.
