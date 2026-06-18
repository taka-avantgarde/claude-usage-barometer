<img src="https://img.shields.io/badge/%E4%BB%85%E9%99%90_macOS-007AFF?style=for-the-badge&logo=apple&logoColor=white" height="40" alt="仅限 macOS">

<div align="center">

🇬🇧 [English](README.md) • 🇯🇵 [日本語](README.ja.md) • 🇪🇸 [Español](README.es.md) • 🇸🇦 [العربية](README.ar.md) • 🇫🇷 [Français](README.fr.md) • 🇩🇪 [Deutsch](README.de.md) • 🇨🇳 **简体中文** • 🇰🇷 [한국어](README.ko.md) • 🇧🇷 [Português](README.pt.md) • 🇳🇱 [Nederlands](README.nl.md) • 🇮🇹 [Italiano](README.it.md) • 🇻🇳 [Tiếng Việt](README.vi.md) • 🇮🇩 [Bahasa Indonesia](README.id.md) • 🇹🇭 [ไทย](README.th.md)

</div>

<div align="center">

# 🎚️ Claude Usage Barometer

**一款紧凑的、电量条样式的菜单栏仪表，用于显示你的 Claude 用量限额。**
实时观察你的 **5 小时** 和 **7 天** 窗口逐渐耗尽——直接在 macOS 菜单栏中。

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

## ⚡ 快速开始

**把这一行粘贴进终端——整个安装就完成了：**

```bash
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/install.sh | bash
```

它会（通过 Homebrew）安装 `jq` + SwiftBar，放入插件并启动它。首次运行时，在钥匙串提示中点击 **Always Allow**。_需要 [Homebrew](https://brew.sh)，并且你已在这台 Mac 上登录 Claude Code。_

---

## 👀 预览

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

`█` = 剩余，`░` = 已用。随着你接近限额，进度条会逐渐排空并变红。

> 📸 把一张真实截图放到 `docs/screenshot.png`，并在此处引用它。

## ✨ 功能特性

- **电量条样式仪表** — `█` 显示剩余量，`░` 显示已用量；随着你消耗配额，它会逐渐排空。
- **颜色编码** — 随着你接近限额，进度条会染上 **绿 → 琥珀 → 红** 的色调（无需单独的图标）。
- **紧凑** — 菜单栏中只显示两条进度条；下拉菜单显示 `% left` 与重置倒计时。
- **对速率限制友好** — 缓存上一次有效读数并限制 API 调用频率（间隔 ≥ 3 分钟），可以挺过短暂的 `429`。
- **更新感知** — 每天检查一次 GitHub，当存在更新的版本时，在下拉菜单中显示一个"有可用更新"的链接。
- **可调刷新频率** — 从下拉菜单中选择 **1 / 3 / 5 min**（当前间隔会显示为 `⏱ Update every N min`）。
- **零构建，纯 Bash。** 易于阅读、审计和调整。设计上注重隐私。

## 🎨 颜色如何工作

进度条的颜色反映 **约束更紧** 的那个窗口距离其限额有多近：

| Used | Color | Meaning |
|-----:|:-----:|:--------|
| `0–69%`  | 🟢 绿色 | 剩余充足 |
| `70–89%` | 🟡 琥珀色 | 即将接近 |
| `90–100%`| 🔴 红色   | 几乎用尽 |

> SwiftBar 为每个菜单栏项目仅着一种颜色，因此菜单栏中的进度条使用两个窗口中更糟的那个。下拉菜单则对每个窗口分别着色。

## 📦 环境要求

- **macOS**，并安装 [SwiftBar](https://github.com/swiftbar/SwiftBar)（或 [xbar](https://github.com/matryer/xbar)）
- **jq** 与 **curl**（curl 随 macOS 自带；通过 `brew install jq` 安装 jq）
- 在这台 Mac 上已登录的 **Claude Code** — 插件会从你的钥匙串中读取它的 OAuth 令牌

## 🚀 安装

### 快速安装（一行）

```bash
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/install.sh | bash
```

通过 Homebrew 安装 `jq` + SwiftBar，放入插件，并启动 SwiftBar。首次运行时，在钥匙串提示中点击 **Always Allow**。

> 需要 [Homebrew](https://brew.sh)，并且你已在这台 Mac 上登录 **Claude Code**。

### 手动安装

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

然后启动 SwiftBar，并将其 **插件文件夹** 指向 `~/SwiftBar`。插件首次运行时，macOS 会请求访问你钥匙串中的 *"Claude Code-credentials"*——点击 **Always Allow**。

> 文件名中的 `.60s.` 表示菜单栏每 60 秒 **重绘** 一次；而 API 本身仅每隔 `MIN_INTERVAL` 秒调用一次（默认 180）。

## ⚙️ 配置

编辑 `claude-usage.60s.sh` 顶部的区块：

| Variable | Default | What it does |
|---|---|---|
| `WARN` / `DANGER` | `70` / `90` | 使进度条变琥珀色 / 红色的已用百分比 |
| `OK_COLOR` / `WARN_COLOR` / `DANGER_COLOR` | 鼠尾草绿 / 赭石色 / 砖红色 | 这三种颜色 |
| `FILL` / `EMPTY` | `█` / `░` | 剩余 / 已用的进度条字符 |
| `MBAR_W` / `DROP_W` | `5` / `10` | 进度条宽度（菜单栏 / 下拉菜单） |
| refresh interval | 菜单 | 从下拉菜单 `⏱` 中选择 **1 / 3 / 5 min**（存储于 `~/.cache/claude-usage-barometer.interval`） |
| `SCALE` | `no` | 如何读取 `utilization`——该端点返回 0–100 的百分比（`no` = 原样使用） |
| `UPDATE_CHECK` | `1` | 每天检查一次 GitHub 是否有更新版本（设为 `0` 以禁用） |

## 🩺 故障排查

| Title | Meaning | Fix |
|---|---|---|
| `Claude …` | 被限速 / 正在预热 | 无需操作——它会每隔几分钟自动重试 |
| `Claude ⚠` | 未找到凭据 | 用 Claude Code 登录 |
| `Claude !` | API 返回了非 200 | 打开下拉菜单查看状态码 / 响应体 |

## 🔒 隐私与免责声明

此插件 **仅** 与 `api.anthropic.com` 通信，使用你机器上已有的令牌。不会把任何内容发送到其他任何地方。上一次读数会本地缓存在 `~/.cache/claude-usage-barometer.tsv`。

它依赖一个 **非官方** 的用量端点（`/api/oauth/usage`），Anthropic 可能随时更改或移除它。一旦它失效，标题会显示 `Claude !`。欢迎提交 PR。

## 🧰 技术栈

| Badge | Role |
|---|---|
| ![Bash](https://img.shields.io/badge/Bash-4EAA25?logo=gnubash&logoColor=white) | 插件运行时（约 90 行） |
| ![jq](https://img.shields.io/badge/jq-1E88E5?logo=json&logoColor=white) | 解析 JSON 响应 |
| ![cURL](https://img.shields.io/badge/cURL-073551?logo=curl&logoColor=white) | 调用用量 API |
| ![SwiftBar](https://img.shields.io/badge/SwiftBar-F05138?logo=swift&logoColor=white) | 在菜单栏中渲染 |
| ![macOS](https://img.shields.io/badge/macOS-000000?logo=apple&logoColor=white) | 钥匙串 + 菜单栏宿主 |
| ![Claude](https://img.shields.io/badge/Claude_API-D97757?logo=anthropic&logoColor=white) | 用量数据来源 |

## 📄 许可证

[MIT](LICENSE) © 2026 Takayuki Miyano · Atlas Associates Inc.
