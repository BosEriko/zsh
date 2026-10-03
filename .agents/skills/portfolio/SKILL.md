---
name: portfolio
description: Generate or refresh the portfolio files of a BosEriko repository (PORTFOLIO.md, COVER.png, ABOUT.md, TOPICS.json) that boseriko.com and the GitHub About section read from, then commit them. Use when the user asks to prepare a repository for the portfolio or invokes /portfolio.
---

# Portfolio

Prepares the current repository for boseriko.com by writing four files at the repository root and committing them.

| File | Purpose |
|---|---|
| `PORTFOLIO.md` | Write-up shown on the repository's page on boseriko.com |
| `COVER.png` | Cover image shown on cards and the repository page |
| `ABOUT.md` | Description and website for the GitHub About section |
| `TOPICS.json` | Topics for the GitHub Topics section |

`ABOUT.md` and `TOPICS.json` are applied to GitHub by the user with `g about`. Never apply them yourself.

## Workflow

1. Confirm the current directory is the root of a Git repository. Stop if it is not.
2. Read the repository metadata:
   ```sh
   gh repo view --json nameWithOwner,description,homepageUrl,defaultBranchRef
   ```
3. Study the repository: README, package or dependency manifests (`package.json`, `Gemfile`, `mix.exs`, `composer.json`, …), configuration files, folder structure, and the source code. Base every statement on what the repository actually contains.
4. Write `PORTFOLIO.md`, `ABOUT.md`, `TOPICS.json`, and `COVER.png` as described below. Replace any existing versions so they stay up to date.
5. Commit the files as described below.
6. Report what was written, the chosen topics, whether `COVER.png` is a screenshot or a branded card, and remind the user to:
   - run `g about` to apply `ABOUT.md` and `TOPICS.json` to GitHub
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
- For the website, use the first of these that is live:
  1. The GitHub homepage URL.
  2. The GitHub Pages URL (`gh api repos/{owner}/{repo}/pages --jq .html_url`) or the domain in a `CNAME` file.
  3. A live URL in the repository: site URL settings in configuration files, `homepage` in `package.json`, or a link in the README.
  4. The registry page when the repository is a published package, for example `https://www.npmjs.com/package/<name>`, `https://rubygems.org/gems/<name>`, or `https://hex.pm/packages/<name>`.
  5. Otherwise, ask the user for the URL. Leave the section empty only when the user confirms there is none.
- A URL is live only when it returns HTTP 200:
  ```sh
  curl -s -L -o /dev/null -w '%{http_code}' --max-time 20 <url>
  ```
- When asking the user, suggest the latest successful production deployment if there is one:
  ```sh
  gh api repos/{owner}/{repo}/deployments --jq '.[] | select(.environment | test("production"; "i")) | .statuses_url' | head -n 1 | xargs gh api --jq '[.[] | select(.state == "success")][0].environment_url'
  ```
  This is usually a per-deployment address such as `<project>-<hash>.vercel.app`, so never use it as the website without the user's confirmation.

## TOPICS.json

A JSON array of topic names, formatted exactly like this:

```json
[
  "typescript",
  "react"
]
```

- Fetch the allowed topics every time:
  ```sh
  curl -s https://raw.githubusercontent.com/BosEriko/BosEriko/refs/heads/master/topics.json | jq -r 'keys[]'
  ```
- Only use keys from that file.
- Never include `product` or `project`. The user decides those.
- Include a topic only when the repository genuinely uses that technology.
- Do not add anything other than the topic names.
- Validate the file with `jq -e 'type == "array" and all(type == "string")' TOPICS.json`.
- Remove a `TOPICS.md` left over from older runs (see Commit).

## COVER.png

A 1600×800 image. Both scripts download Chrome's headless shell to `~/.cache/portfolio-skill` on first use.

When the website from `ABOUT.md` is a live site of the project, take a screenshot of it. When the website is empty but there is a live production deployment, take the screenshot of the deployment instead:

```sh
~/.agents/skills/portfolio/scripts/cover.sh <website-url> COVER.png
```

Look at the screenshot after taking it. If it shows an error page, a login wall, or a blank page, use the branded card instead.

In every other case (no live site to screenshot, the website is a registry page, or the screenshot is unusable), generate a branded card:

```sh
~/.agents/skills/portfolio/scripts/card.py \
  --name "<product name>" \
  --tagline "<first sentence of the ABOUT.md description>" \
  --label "<owner/repo>" \
  --topics $(jq -r '.[]' TOPICS.json) \
  --output COVER.png
```

Look at the card after generating it and check that the text is not cut off.

## Commit

- Stage only the portfolio files that were written:
  ```sh
  git rm -q --ignore-unmatch TOPICS.md
  git add PORTFOLIO.md ABOUT.md TOPICS.json COVER.png
  ```
- Commit with a Gitmoji message that ends with today's date:
  ```sh
  git commit -m "📝 Update portfolio files ($(date +%F))"
  ```
- Do not include any other changes in the commit.
- Do not add yourself, an AI assistant, or any tool as an author or co-author, and do not add `Co-authored-by` lines.
- Do not push.
