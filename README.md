<div align="center">

# 🎚️ Claude Usage Barometer

**A menu-bar gauge for your Claude usage limits.**
See your **5-hour** and **7-day** windows at a glance — with 🟢 / 🟡 / 🔴 status marks, right from the macOS menu bar.

[**English**](README.md) · [日本語](README.ja.md)

<br>

<img src="https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white" alt="Bash">
<img src="https://img.shields.io/badge/jq-1E88E5?style=for-the-badge&logo=json&logoColor=white" alt="jq">
<img src="https://img.shields.io/badge/cURL-073551?style=for-the-badge&logo=curl&logoColor=white" alt="cURL">
<img src="https://img.shields.io/badge/SwiftBar-F05138?style=for-the-badge&logo=swift&logoColor=white" alt="SwiftBar">
<img src="https://img.shields.io/badge/macOS-000000?style=for-the-badge&logo=apple&logoColor=white" alt="macOS">
<img src="https://img.shields.io/badge/Claude_API-D97757?style=for-the-badge&logo=anthropic&logoColor=white" alt="Claude API">

<br>

<img src="https://img.shields.io/badge/license-MIT-FBC02D?style=flat-square" alt="MIT">
<img src="https://img.shields.io/badge/PRs-welcome-5E9C6B?style=flat-square" alt="PRs welcome">
<img src="https://img.shields.io/badge/platform-macOS%2012%2B-555555?style=flat-square&logo=apple&logoColor=white" alt="platform">
<img src="https://img.shields.io/badge/runtime-zero%20build-1E88E5?style=flat-square" alt="zero build">

</div>

---

## 👀 Preview

```text
 menu bar:   …   5h ███░░ 63% 🟢   7d █░░░░ 13% 🟢   ⏰ Mon 14:32

 click ▼
 ┌────────────────────────────────────┐
 │ 5-hour   ██████░░░░   63% 🟢        │
 │          resets in 2h 10m          │
 │ 7-day    █░░░░░░░░░   13% 🟢        │
 │          resets in 2d 8h           │
 │ ────────────────────────────────── │
 │ Updated 14:32:05                   │
 │ Refresh now                        │
 └────────────────────────────────────┘
```

> 📸 Drop a real screenshot at `docs/screenshot.png` and reference it here.

## ✨ Features

- **Status at a glance** — a 🟢 / 🟡 / 🔴 mark after each percentage (green → amber → red as you approach the limit).
- **Always legible** — the bars and numbers use the system label color (black on light menu bars, white on dark), so they never wash out against the menu bar.
- **Both windows** — 5-hour and 7-day, side by side, each with its own mark.
- **Reset countdown** — the dropdown shows when each window refreshes (`resets in 2h 10m`).
- **Rate-limit friendly** — caches the last good reading and throttles API calls (≥ 3 min apart), so a brief `429` shows the last value instead of an error.
- **Zero build, pure Bash.** Easy to read, audit, and tweak. Private by design.

## 🚦 Status marks

The mark reflects how much of a window you've **used**:

| Usage | Mark | Meaning |
|------:|:----:|:--------|
| `0–69%`  | 🟢 | Plenty left |
| `70–89%` | 🟡 | Getting close |
| `90–100%`| 🔴 | Almost out |

Prefer different glyphs? Set `SYM_OK` / `SYM_WARN` / `SYM_DANGER` in the config (e.g. `🟢 ⚠️ ❗` or monochrome `● ▲ !`). Dropdown rows are additionally tinted via `OK_COLOR` / `WARN_COLOR` / `DANGER_COLOR`.

## 📦 Requirements

- **macOS** with [SwiftBar](https://github.com/swiftbar/SwiftBar) (or [xbar](https://github.com/matryer/xbar))
- **jq** and **curl** (curl ships with macOS; install jq via `brew install jq`)
- **Claude Code** signed in on this Mac — the plugin reads its OAuth token from your Keychain

## 🚀 Installation

```bash
# 1. Dependencies (curl is preinstalled on macOS)
brew install jq
brew install --cask swiftbar

# 2. Drop the plugin into your SwiftBar plugin folder
mkdir -p ~/SwiftBar
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/claude-usage.60s.sh \
  -o ~/SwiftBar/claude-usage.60s.sh
chmod +x ~/SwiftBar/claude-usage.60s.sh
```

Then launch SwiftBar and point its **plugin folder** to `~/SwiftBar`. The first time the plugin runs, macOS asks to access *"Claude Code-credentials"* in your Keychain — click **Always Allow**.

> The `.60s.` in the filename means the menu bar **redraws** every 60 seconds; the API itself is only called every `MIN_INTERVAL` seconds (default 180). Rename to `.5m.`, `.1h.`, etc. to change the redraw cadence.

## ⚙️ Configuration

Edit the block at the top of `claude-usage.60s.sh`:

| Variable | Default | What it does |
|---|---|---|
| `WARN` / `DANGER` | `70` / `90` | % used that flips the mark to 🟡 / 🔴 |
| `SYM_OK` / `SYM_WARN` / `SYM_DANGER` | 🟢 / 🟡 / 🔴 | the status marks after the % |
| `OK_COLOR` / `WARN_COLOR` / `DANGER_COLOR` | sage / ochre / brick | dropdown row tint |
| `MIN_INTERVAL` | `180` | min seconds between real API calls (rate-limit guard) |
| `MBAR_W` / `DROP_W` | `5` / `10` | bar width (menu bar / dropdown) |
| `SCALE` | `auto` | how to read `utilization` (`auto`, `yes`, `no`) |

## 🩺 Troubleshooting

The menu-bar title tells you what happened:

| Title | Meaning | Fix |
|---|---|---|
| `Claude …` | Rate limited / warming up | Nothing — it auto-retries every few minutes |
| `Claude ⚠` | No credentials found | Sign in with Claude Code |
| `Claude !` | API returned non-200 | Open the dropdown for the status code / body |
| `Claude ?` | Unexpected JSON shape | The endpoint changed — open the dropdown to inspect |

## 🔒 Privacy & disclaimer

This plugin talks **only** to `api.anthropic.com`, using the token already on your machine. Nothing is sent anywhere else. The last reading is cached locally at `~/.cache/claude-usage-barometer.tsv`.

It relies on an **unofficial** usage endpoint (`/api/oauth/usage`) that Anthropic may change or remove at any time. If it ever breaks, the title shows `Claude !` or `Claude ?`. PRs welcome.

## 🧰 Tech stack

| Badge | Role |
|---|---|
| ![Bash](https://img.shields.io/badge/Bash-4EAA25?logo=gnubash&logoColor=white) | Plugin runtime (~90 lines) |
| ![jq](https://img.shields.io/badge/jq-1E88E5?logo=json&logoColor=white) | Parse the JSON response |
| ![cURL](https://img.shields.io/badge/cURL-073551?logo=curl&logoColor=white) | Call the usage API |
| ![SwiftBar](https://img.shields.io/badge/SwiftBar-F05138?logo=swift&logoColor=white) | Render in the menu bar |
| ![macOS](https://img.shields.io/badge/macOS-000000?logo=apple&logoColor=white) | Keychain + menu-bar host |
| ![Claude](https://img.shields.io/badge/Claude_API-D97757?logo=anthropic&logoColor=white) | Usage data source |

## 📄 License

[MIT](LICENSE) © 2026 Takayuki Miyano · Atlas Associates Inc.
