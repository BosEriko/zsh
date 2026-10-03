---
name: portfolio
description: Generate or refresh the portfolio files of a BosEriko repository (PORTFOLIO.md, COVER.png, ABOUT.md, TOPICS.md) that boseriko.com and the GitHub About section read from, then commit them. Use when the user asks to prepare a repository for the portfolio or invokes /portfolio.
---

# Portfolio

Prepares the current repository for boseriko.com by writing four files at the repository root and committing them.

| File | Purpose |
|---|---|
| `PORTFOLIO.md` | Write-up shown on the repository's page on boseriko.com |
| `COVER.png` | Cover image shown on cards and the repository page |
| `ABOUT.md` | Description and website for the GitHub About section |
| `TOPICS.md` | Topics for the GitHub Topics section |

`ABOUT.md` and `TOPICS.md` are applied to GitHub by the user with `g about`. Never apply them yourself.

## Workflow

1. Confirm the current directory is the root of a Git repository. Stop if it is not.
2. Read the repository metadata:
   ```sh
   gh repo view --json nameWithOwner,description,homepageUrl,defaultBranchRef
   ```
3. Study the repository: README, package or dependency manifests (`package.json`, `Gemfile`, `mix.exs`, `composer.json`, …), configuration files, folder structure, and the source code. Base every statement on what the repository actually contains.
4. Write `PORTFOLIO.md`, `ABOUT.md`, `TOPICS.md`, and `COVER.png` as described below. Replace any existing versions so they stay up to date.
5. Commit the files as described below.
6. Report what was written, the chosen topics, whether `COVER.png` was created, and remind the user to:
   - run `g about` to apply `ABOUT.md` and `TOPICS.md` to GitHub
   - add `product` or `project` to the GitHub topics themselves

## PORTFOLIO.md

Written for visitors of boseriko.com, not for developers.

```markdown
# <Product name>

<Two or three plain sentences: what it is and who it is for.>

---

## <What it does>

- <Feature, described by what the user gets>

## <Another relevant section>

...
```

- Use the product's real name as the title, not the repository slug, when it has one.
- Use `##` sections with short bullet lists. Choose section names that fit the project.
- Describe features by what they let people do.
- Do not include installation steps, setup, commands, badges, images, or links to the repository.
- Do not invent features, users, or metrics.

## ABOUT.md

Use exactly this format:

```markdown
# About

## Description

<description>

## Website

<url>
```

- The description must be at most 350 characters.
- Write it as short, complete sentences separated by `. `. The resume on boseriko.com turns each sentence into a bullet point.
- The first sentence must stand on its own; project cards only show the first two lines.
- For the website, use the GitHub homepage URL if set, otherwise a live URL found in the repository (for example `homepage` in `package.json` or the README). Leave the section empty when there is none.

## TOPICS.md

Use exactly this format:

```markdown
# Topics

- <topic>
- <topic>
```

- Fetch the allowed topics every time:
  ```sh
  curl -s https://raw.githubusercontent.com/BosEriko/BosEriko/refs/heads/master/topics.json | jq -r 'keys[]'
  ```
- Only use keys from that file.
- Never include `product` or `project`. The user decides those.
- Include a topic only when the repository genuinely uses that technology.
- Do not add reasons or any other text.

## COVER.png

A 1600×800 screenshot of the website from `ABOUT.md`:

```sh
~/.agents/skills/portfolio/scripts/cover.sh <website-url> COVER.png
```

- The script downloads Chrome's headless shell to `~/.cache/portfolio-skill` on first use.
- Look at the screenshot after taking it. If it shows an error page, a login wall, or a blank page, delete it and tell the user.
- When there is no website, do not create `COVER.png`; leave any existing one untouched and tell the user boseriko.com will fall back to GitHub's generated image.

## Commit

- Stage only the portfolio files that were written:
  ```sh
  git add PORTFOLIO.md ABOUT.md TOPICS.md COVER.png
  ```
  Leave out `COVER.png` when it was not created.
- Commit with a Gitmoji message that ends with today's date:
  ```sh
  git commit -m "📝 Update portfolio files ($(date +%F))"
  ```
- Do not include any other changes in the commit.
- Do not add yourself, an AI assistant, or any tool as an author or co-author, and do not add `Co-authored-by` lines.
- Do not push.
