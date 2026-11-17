---
name: taskify
description: Turn a plan or task into GitHub issues on the current repository and add them to the project board set in taskify.json, splitting big work into an epic with sub-issues.
argument-hint: "What should be turned into issues? Defaults to the current plan."
disable-model-invocation: true
---

# Taskify

If the user passed arguments, treat them as the work to turn into issues. Otherwise use the most recent plan in the conversation. If there is neither, ask what to turn into issues.

## 1. Check gh

Run `~/.agents/skills/taskify/scripts/taskify.sh` from the repository root. It installs `gh` with Homebrew when it is missing, and prints one result:

- `ok`: continue.
- `no-gh` or `install-failed`: tell the user `gh` could not be installed and to install it from https://cli.github.com, then stop.
- `not-logged-in`: ask the user to run `! gh auth login`, then run the script again.
- `missing-project-scope` or `missing-repo-scope`: explain that creating issues and adding them to a project needs the `repo` and `project` scopes, ask the user to run `! gh auth refresh -s repo,project`, then run the script again.

If a later `gh` command fails with a permission error, explain which permission is missing and ask the user to grant it the same way.

## 2. Find the project

Read `taskify.json` at the repository root:

```json
{
  "project": {
    "owner": "<user or org login>",
    "number": 1
  }
}
```

If the file or its `project` entry is missing, list the projects with `gh project list --owner <repo owner> --format json` and `gh project list --owner @me --format json`, and ask the user to pick one with AskUserQuestion. Write the choice to `taskify.json`, keeping any other keys already in the file.

If no projects exist, tell the user and ask whether to create one with `gh project create --owner <owner> --title <title>`.

## 3. Draft the issues

Turn the work into issues. Each issue gets a short imperative title and a body with the context, what to do, and acceptance criteria.

If the work is big enough that it would take more than one pull request, or it has parts that can be done independently, offer to split it: one epic issue describing the overall goal, plus one sub-issue per part. Let the user choose between the split and a single issue.

Show the drafted issues and ask for approval before creating anything.

## 4. Create the issues

1. Make sure the issue types and labels the issues need exist:
   - List issue types with `gh api graphql -f query='{repository(owner:"<owner>",name:"<repo>"){issueTypes(first:50){nodes{name}}}}'`. Give the epic the `Epic` type and every other issue its matching type, such as `Task`, `Bug`, or `Feature`.
   - If a type is missing and the repository belongs to an organization, create it with the `createIssueType` mutation, using the organization's node ID as `ownerId`. This needs the `admin:org` scope. If it's missing, ask the user to run `! gh auth refresh -s admin:org`.
   - If a type is missing and can't be created, because the repository is user-owned or the user lacks permission, use a label with the type's name instead, such as `epic`.
   - List labels with `gh label list --json name`, and create each missing label with `gh label create <name>`.
2. Create the epic first, if there is one: `gh issue create --title <title> --body-file <file>` with its `--type` or `--label`.
3. Create each sub-issue with `--parent <epic number>` and its `--type` or `--label`.
4. Rewrite the epic's body with a `## Tasks` checklist containing one `- [ ] #<number>` line per sub-issue, using `gh issue edit <epic number> --body-file <file>`. The epic then shows both the native sub-issues and the checklist.
5. Add every created issue, epic included, to the project: `gh project item-add <number> --owner <owner> --url <issue url>`.

Write issue bodies to files in the scratchpad directory and pass them with `--body-file`.

## 5. Report

Reply with a table of every created issue, epic first, with these columns:

| # | Title | Type | Parent | URL |
|---|---|---|---|---|

Use the issue type or fallback label for Type, the epic's number for Parent (`—` for the epic or a single issue), and the full issue URL for URL.

Below the table, confirm the issues were added to the project, list any issue types or labels that were created and any type that fell back to a label, and report anything that failed.

## Rules

- Create issues on the current repository only. The project in `taskify.json` is only where they are tracked.
- Never create issues without the user's approval of the draft.
- Do not invent work that isn't in the plan or task.
