<img src="https://img.shields.io/badge/macOS_only-007AFF?style=for-the-badge&logo=apple&logoColor=white" height="40" alt="macOS only">

<div align="center">

🇬🇧 **English** • 🇯🇵 [日本語](README.ja.md) • 🇪🇸 [Español](README.es.md) • 🇸🇦 [العربية](README.ar.md) • 🇫🇷 [Français](README.fr.md) • 🇩🇪 [Deutsch](README.de.md) • 🇨🇳 [简体中文](README.zh.md) • 🇰🇷 [한국어](README.ko.md) • 🇧🇷 [Português](README.pt.md) • 🇳🇱 [Nederlands](README.nl.md) • 🇮🇹 [Italiano](README.it.md) • 🇻🇳 [Tiếng Việt](README.vi.md) • 🇮🇩 [Bahasa Indonesia](README.id.md) • 🇹🇭 [ไทย](README.th.md)

</div>

<div align="center">

# 🎚️ Claude Usage Barometer

**A compact, battery-style menu-bar gauge for your Claude usage limits.**
Watch your **5-hour** and **7-day** windows drain in real time — right from the macOS menu bar.

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

## ⚡ Quick start

**Paste this one line into Terminal — that's the whole setup:**

```bash
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/install.sh | bash
```

It installs `jq` + SwiftBar (via Homebrew), drops in the plugin, and launches it. On first run, click **Always Allow** for the Keychain prompt. _Requires [Homebrew](https://brew.sh) and that you're signed in to Claude Code on this Mac._

---

## 👀 Preview

```text
 menu bar:   …   5h ██░░░  7d ████░       (green → amber → red)

 click ▼
 ┌────────────────────────────────────┐
 │ 5-hour   ████░░░░░░   37% left      │
 │          resets in 2h 10m          │
 │ 7-day    █████████░   87% left      │
 │          resets in 2d 8h           │
 │ ────────────────────────────────── │
 │ Updated 14:32:05                   │
 │ Refresh now                        │
 └────────────────────────────────────┘
```

`█` = remaining, `░` = used up. The bar drains and reddens as you approach the limit.

> 📸 Drop a real screenshot at `docs/screenshot.png` and reference it here.

## ✨ Features

- **Battery-style gauge** — `█` shows what's left, `░` what's used; it drains as you consume your quota.
- **Color-coded** — the bar is tinted **green → amber → red** as you near the limit (no separate icon needed).
- **Compact** — just the two bars in the menu bar; the dropdown shows `% left` and the reset countdown.
- **Rate-limit friendly** — caches the last good reading and throttles API calls (≥ 3 min apart), surviving brief `429`s.
- **Update-aware** — checks GitHub once a day and shows an "update available" link in the dropdown when a newer release exists.
- **Adjustable refresh** — pick **1 / 3 / 5 min** from the dropdown (the current interval is shown as `⏱ Update every N min`).
- **Zero build, pure Bash.** Easy to read, audit, and tweak. Private by design.

## 🎨 How the color works

The bar's color reflects how close the **more-constrained** window is to its limit:

| Used | Color | Meaning |
|-----:|:-----:|:--------|
| `0–69%`  | 🟢 green | Plenty left |
| `70–89%` | 🟡 amber | Getting close |
| `90–100%`| 🔴 red   | Almost out |

> SwiftBar paints each menu-bar item a single color, so the menu-bar bar uses the worse of the two windows. The dropdown tints each window individually.

## 📦 Requirements

- **macOS** with [SwiftBar](https://github.com/swiftbar/SwiftBar) (or [xbar](https://github.com/matryer/xbar))
- **jq** and **curl** (curl ships with macOS; install jq via `brew install jq`)
- **Claude Code** signed in on this Mac — the plugin reads its OAuth token from your Keychain

## 🚀 Installation

### Quick install (one line)

```bash
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/install.sh | bash
```

Installs `jq` + SwiftBar via Homebrew, drops in the plugin, and launches SwiftBar. On first run, click **Always Allow** for the Keychain prompt.

> Requires [Homebrew](https://brew.sh) and that you're signed in to **Claude Code** on this Mac.

### Manual install

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

> The `.60s.` in the filename means the menu bar **redraws** every 60 seconds; the API itself is only called every `MIN_INTERVAL` seconds (default 180).

## ⚙️ Configuration

Edit the block at the top of `claude-usage.60s.sh`:

| Variable | Default | What it does |
|---|---|---|
| `WARN` / `DANGER` | `70` / `90` | % used that turns the bar amber / red |
| `OK_COLOR` / `WARN_COLOR` / `DANGER_COLOR` | sage / ochre / brick | the three colors |
| `FILL` / `EMPTY` | `█` / `░` | remaining / used-up bar characters |
| `MBAR_W` / `DROP_W` | `5` / `10` | bar width (menu bar / dropdown) |
| refresh interval | menu | pick **1 / 3 / 5 min** from the dropdown `⏱` (stored in `~/.cache/claude-usage-barometer.interval`) |
| `SCALE` | `no` | how to read `utilization` — the endpoint returns 0–100 percentages (`no` = as-is) |
| `UPDATE_CHECK` | `1` | check GitHub once a day for a newer release (`0` to disable) |

## 🩺 Troubleshooting

| Title | Meaning | Fix |
|---|---|---|
| `Claude …` | Rate limited / warming up | Nothing — it auto-retries every few minutes |
| `Claude ⚠` | No credentials found | Sign in with Claude Code |
| `Claude !` | API returned non-200 | Open the dropdown for the status code / body |

## 🔒 Privacy & disclaimer

This plugin talks **only** to `api.anthropic.com`, using the token already on your machine. Nothing is sent anywhere else. The last reading is cached locally at `~/.cache/claude-usage-barometer.tsv`.

It relies on an **unofficial** usage endpoint (`/api/oauth/usage`) that Anthropic may change or remove at any time. If it ever breaks, the title shows `Claude !`. PRs welcome.

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
