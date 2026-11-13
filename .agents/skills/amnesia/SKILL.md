---
name: amnesia
description: Delete all but the latest 10 handoff documents in every directory of the handoff folder.
disable-model-invocation: true
---

Run `~/.agents/skills/handoff/scripts/handoff.sh prune`. It goes through every directory in the handoff folder, keeps the latest 10 handoff documents in each, deletes the rest, and prints the paths it deleted.

Report which handoff documents were deleted, or that nothing was deleted if nothing was printed.
