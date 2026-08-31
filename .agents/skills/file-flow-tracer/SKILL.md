---
name: file-flow-tracer
description: Trace how a request, event, job, or operation moves between repository files and report a concise file-by-file calling flow with current line links and analogous local implementations. Use when the user wants to follow execution through handlers, publishers, infrastructure wiring, application logic, repositories, or similar code paths.
---

# File Flow Tracer

Trace the concrete runtime path through the repository, starting from the entry point named by the user or the closest discoverable entry point.

## Workflow

1. Locate the entry point and relevant identifiers with targeted `rg` searches.
2. Follow actual calls, subscriptions, routes, handlers, and repository operations in execution order.
3. Distinguish infrastructure definitions from runtime calls; include infrastructure files only where they connect two runtime stages.
4. For each changed or task-specific file, search for the nearest existing file with the same responsibility and pattern.
5. Re-read the final files with line-numbered output so links use current line numbers.
6. Return the shortest complete flow that answers the question.

## Output

Use one ordered chain. For each stage, provide a clickable absolute file link with a single current line number and one short description:

```text
File A:line
→ receives or creates the event
→ similar to: Existing File X

File B:line
→ calls or routes to the next stage
→ similar to: Existing File Y
```

Add `similar to` only when inspection confirms a meaningful local precedent. Prefer a clickable link to the analogous file and briefly note any important difference, such as intentionally omitted idempotency. Do not force a comparison when no close equivalent exists.

Include conditional branches only when they materially affect the requested flow. If correlation is indirect, such as resolving a deposit and obtaining its session token, state that explicitly. Do not imply that infrastructure declarations execute at runtime by themselves.

## Constraints

- Base the trace on inspected code, not file names or assumptions.
- Prefer the exact call or routing line over a class or function declaration line.
- Base similarity claims on inspected structure and behavior, not naming alone.
- Use absolute local Markdown links when the interface supports them.
- Keep descriptions brief unless the user requests a detailed explanation.
- Do not modify repository files while tracing.
