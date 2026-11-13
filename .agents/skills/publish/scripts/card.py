#!/usr/bin/env python3
import argparse
import html
import json
import os
import subprocess
import tempfile
import urllib.request

TOPICS_URL = "https://raw.githubusercontent.com/BosEriko/BosEriko/refs/heads/master/topics.json"
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))

LOGO = """<svg viewBox="0 0 16 16" shape-rendering="crispEdges" width="40" height="40">
<rect width="16" height="16" rx="2" fill="#1a1714"/>
<path d="M9 2h2v2h-2zM11 4h2v3h-2zM8 7h3v2h-3zM11 9h2v3h-2zM9 12h2v2h-2z" fill="#f6f1e7"/>
<path d="M3 2h2v12h-2zM5 2h4v2h-4zM5 7h3v2h-3zM5 12h4v2h-4z" fill="#f7b43d"/>
</svg>"""

TEMPLATE = """<!doctype html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Geist:wght@400;500&family=Geist+Mono&family=Instrument+Serif:ital@0;1&display=block">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/devicon@2.17.0/devicon.min.css">
<style>
  * {{ box-sizing: border-box; margin: 0; }}
  body {{ width: 1600px; height: 800px; overflow: hidden; position: relative; background: #f6f1e7; color: #1a1714; font-family: "Geist", sans-serif; }}
  .mono {{ font-family: "Geist Mono", monospace; }}
  .left {{ position: absolute; left: 96px; top: 88px; width: 820px; }}
  .brand {{ display: flex; align-items: center; gap: 16px; font-size: 18px; letter-spacing: 0.2em; text-transform: uppercase; color: #776e62; }}
  .name {{ margin-top: 56px; font-family: "Instrument Serif", serif; font-size: {name_size}px; line-height: 0.92; letter-spacing: -0.01em; overflow-wrap: anywhere; }}
  .tagline {{ margin-top: 36px; font-size: 30px; line-height: 1.45; color: #3d3730; display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden; }}
  .pills {{ position: absolute; left: 96px; bottom: 88px; display: flex; flex-wrap: wrap; gap: 12px; width: 860px; }}
  .pill {{ display: flex; align-items: center; gap: 10px; border: 1.5px solid #ddd3c2; border-radius: 4px; padding: 10px 16px; font-size: 17px; letter-spacing: 0.05em; text-transform: uppercase; color: #3d3730; }}
  .pill i {{ font-size: 22px; }}
  .window {{ position: absolute; right: 120px; top: 112px; width: 500px; border: 4px solid #1a1714; border-radius: 4px; background: #1a1714; box-shadow: 20px 20px 0 #f7b43d; }}
  .bar {{ display: flex; align-items: center; gap: 8px; padding: 14px 16px; font-size: 14px; letter-spacing: 0.15em; color: rgba(246, 241, 231, 0.6); text-transform: lowercase; }}
  .bar span.dot {{ flex-shrink: 0; width: 9px; height: 9px; background: rgba(246, 241, 231, 0.25); }}
  .bar span.dot.on {{ background: #f7b43d; }}
  .bar .label {{ margin-left: 10px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }}
  .screen {{ position: relative; height: 480px; overflow: hidden; display: flex; align-items: center; justify-content: center; background: #24201c; }}
  .screen::after {{ content: ""; position: absolute; inset: 0; background: repeating-linear-gradient(0deg, rgba(0, 0, 0, 0.25) 0 1px, transparent 1px 4px); }}
  .initial {{ font-family: "Instrument Serif", serif; font-style: italic; font-size: 400px; line-height: 1; color: #f7b43d; transform: translateY(-12px); }}
  .corner {{ position: absolute; width: 36px; height: 36px; border-color: #f7b43d; border-style: solid; border-width: 0; z-index: 1; }}
  .tl {{ top: 20px; left: 20px; border-top-width: 3px; border-left-width: 3px; }}
  .tr {{ top: 20px; right: 20px; border-top-width: 3px; border-right-width: 3px; }}
  .bl {{ bottom: 20px; left: 20px; border-bottom-width: 3px; border-left-width: 3px; }}
  .br {{ bottom: 20px; right: 20px; border-bottom-width: 3px; border-right-width: 3px; }}
</style>
</head>
<body>
  <div class="left">
    <div class="brand mono">{logo}<span>boseriko.com</span></div>
    <h1 class="name">{name}</h1>
    <p class="tagline">{tagline}</p>
  </div>
  <div class="pills mono">{pills}</div>
  <div class="window">
    <div class="bar mono"><span class="dot"></span><span class="dot"></span><span class="dot on"></span><span class="label">{label}</span></div>
    <div class="screen">
      <span class="corner tl"></span><span class="corner tr"></span><span class="corner bl"></span><span class="corner br"></span>
      <span class="initial">{initial}</span>
    </div>
  </div>
</body>
</html>
"""


def name_size(name):
    length = len(name)
    if length <= 10:
        return 168
    if length <= 16:
        return 132
    if length <= 24:
        return 104
    return 84


def build_pills(topics):
    with urllib.request.urlopen(TOPICS_URL) as response:
        data = json.load(response)

    pills = []
    for topic in topics:
        info = data.get(topic)
        if not info or topic in ("product", "project"):
            continue
        icon = ""
        if info.get("deviconClass"):
            icon = f'<i class="{html.escape(info["deviconClass"])}" style="color: {html.escape(info.get("bg") or "#776e62")}"></i>'
        pills.append(f'<span class="pill">{icon}{html.escape(info.get("title") or topic)}</span>')
    return "".join(pills)


def main():
    parser = argparse.ArgumentParser(description="Render a branded 1600x800 cover card.")
    parser.add_argument("--name", required=True)
    parser.add_argument("--tagline", required=True)
    parser.add_argument("--label", required=True)
    parser.add_argument("--topics", nargs="*", default=[])
    parser.add_argument("--output", default="COVER.png")
    args = parser.parse_args()

    initial = next((char for char in args.name if char.isalnum()), "?").upper()
    page = TEMPLATE.format(
        name_size=name_size(args.name),
        logo=LOGO,
        name=html.escape(args.name),
        tagline=html.escape(args.tagline),
        label=html.escape(args.label),
        pills=build_pills(args.topics),
        initial=html.escape(initial),
    )

    with tempfile.NamedTemporaryFile("w", suffix=".html", delete=False, encoding="utf-8") as file:
        file.write(page)
        page_path = file.name

    try:
        subprocess.run(
            [os.path.join(SCRIPT_DIR, "cover.sh"), f"file://{page_path}", os.path.abspath(args.output)],
            check=True,
        )
    finally:
        os.unlink(page_path)


if __name__ == "__main__":
    main()
