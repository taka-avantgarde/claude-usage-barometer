<div align="center">

# 🎚️ Claude Usage Barometer

**Claude の使用量をメニューバーに表示するゲージ。**
**5時間**枠と**7日間**枠の残量を、🟢 / 🟡 / 🔴 のマーク付きで一目で確認できます。

[English](README.md) · [**日本語**](README.ja.md)

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

## 👀 プレビュー

```text
 メニューバー:   …   5h ███░░ 63% 🟢   7d █░░░░ 13% 🟢   ⏰ Mon 14:32

 クリック ▼
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

> 📸 実際のスクリーンショットを `docs/screenshot.png` に置いて、ここで参照してください。

## ✨ 特長

- **一目で状態がわかる** — 各％の後ろに 🟢 / 🟡 / 🔴 マーク（上限に近づくほど 緑→黄→赤）。
- **常にくっきり** — 文字とバーはシステムの標準色（明るいバーでは黒、暗いバーでは白）なので、背景に埋もれません。
- **2つの枠** — 5時間枠と7日間枠を横並びで、それぞれにマーク付き。
- **リセットまでの時間** — ドロップダウンに各枠の回復時刻（`resets in 2h 10m`）。
- **レート制限に強い** — 直近の正常値をキャッシュし、API呼び出しを間引き（最短3分間隔）。一時的な `429` でも最後の値を表示し続けます。
- **ビルド不要・純Bash。** 読みやすく改造も簡単。プライバシー重視。

## 🚦 ステータスマーク

マークは、その枠を **どれだけ使ったか** を表します:

| 使用率 | マーク | 意味 |
|------:|:----:|:--------|
| `0–69%`  | 🟢 | 余裕あり |
| `70–89%` | 🟡 | 注意 |
| `90–100%`| 🔴 | ほぼ上限 |

別の記号にしたい場合は `SYM_OK` / `SYM_WARN` / `SYM_DANGER` を変更（例: `🟢 ⚠️ ❗`、モノクロの `● ▲ !` など）。ドロップダウンの行は `OK_COLOR` / `WARN_COLOR` / `DANGER_COLOR` で色付けされます。

## 📦 必要なもの

- **macOS** と [SwiftBar](https://github.com/swiftbar/SwiftBar)（または [xbar](https://github.com/matryer/xbar)）
- **jq** と **curl**（curl は macOS 標準搭載／jq は `brew install jq`）
- この Mac に **Claude Code** でサインイン済みであること（Keychain から OAuth トークンを読みます）

## 🚀 インストール

```bash
# 1. 依存ツール（curl は macOS に標準搭載）
brew install jq
brew install --cask swiftbar

# 2. プラグインを SwiftBar のプラグインフォルダに置く
mkdir -p ~/SwiftBar
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/claude-usage.60s.sh \
  -o ~/SwiftBar/claude-usage.60s.sh
chmod +x ~/SwiftBar/claude-usage.60s.sh
```

その後 SwiftBar を起動し、**プラグインフォルダ**を `~/SwiftBar` に設定します。初回実行時に macOS が Keychain の *「Claude Code-credentials」* へのアクセスを尋ねたら、**「常に許可」** を押してください。

> ファイル名の `.60s.` は**メニューバーの再描画**が60秒ごとという意味です。API自体は `MIN_INTERVAL` 秒（既定180）に1回しか呼びません。`.5m.`、`.1h.` などに変えると再描画間隔を変更できます。

## ⚙️ 設定

`claude-usage.60s.sh` の冒頭ブロックを編集します:

| 変数 | 既定値 | 役割 |
|---|---|---|
| `WARN` / `DANGER` | `70` / `90` | マークが 🟡 / 🔴 に変わる使用率(%) |
| `SYM_OK` / `SYM_WARN` / `SYM_DANGER` | 🟢 / 🟡 / 🔴 | ％の後ろのステータスマーク |
| `OK_COLOR` / `WARN_COLOR` / `DANGER_COLOR` | セージ / オーカー / ブリック | ドロップダウンの行の色 |
| `MIN_INTERVAL` | `180` | API呼び出しの最短間隔(秒)。レート制限対策 |
| `MBAR_W` / `DROP_W` | `5` / `10` | バーの幅（メニューバー / ドロップダウン） |
| `SCALE` | `auto` | `utilization` の解釈方法（`auto`, `yes`, `no`） |

## 🩺 トラブルシューティング

メニューバーのタイトルが状態を教えてくれます:

| 表示 | 意味 | 対処 |
|---|---|---|
| `Claude …` | レート制限中／起動直後 | 何もしなくてOK。数分で自動的に復帰します |
| `Claude ⚠` | 資格情報が見つからない | Claude Code でサインイン |
| `Claude !` | API が 200 以外を返した | ドロップダウンでステータスコード／本文を確認 |
| `Claude ?` | JSON の形が想定外 | エンドポイントが変わった可能性。ドロップダウンで確認 |

## 🔒 プライバシーと免責

このプラグインは、お使いの Mac にあるトークンを使って **`api.anthropic.com` だけ** と通信します。それ以外へは何も送信しません。直近の値は `~/.cache/claude-usage-barometer.tsv` にローカル保存されます。

利用しているのは **非公式** の使用量エンドポイント（`/api/oauth/usage`）で、Anthropic 側の都合でいつでも変更・廃止される可能性があります。動かなくなった場合はタイトルに `Claude !` または `Claude ?` が出ます。PR 歓迎です。

## 🧰 技術スタック

| バッジ | 役割 |
|---|---|
| ![Bash](https://img.shields.io/badge/Bash-4EAA25?logo=gnubash&logoColor=white) | プラグインの実行（約90行） |
| ![jq](https://img.shields.io/badge/jq-1E88E5?logo=json&logoColor=white) | JSON レスポンスの解析 |
| ![cURL](https://img.shields.io/badge/cURL-073551?logo=curl&logoColor=white) | 使用量 API の呼び出し |
| ![SwiftBar](https://img.shields.io/badge/SwiftBar-F05138?logo=swift&logoColor=white) | メニューバーへの描画 |
| ![macOS](https://img.shields.io/badge/macOS-000000?logo=apple&logoColor=white) | Keychain ＋ メニューバー |
| ![Claude](https://img.shields.io/badge/Claude_API-D97757?logo=anthropic&logoColor=white) | 使用量データの取得元 |

## 📄 ライセンス

[MIT](LICENSE) © 2026 Takayuki Miyano · Atlas Associates Inc.
