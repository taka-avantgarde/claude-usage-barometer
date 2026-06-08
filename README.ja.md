<div align="center">

# 🎚️ Claude Usage Barometer

**Claude の使用量を表示する、コンパクトな電池式メニューバー・ゲージ。**
**5時間**枠と**7日間**枠の残量が、macOS のメニューバーでリアルタイムに減っていきます。

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
 メニューバー:   …   5h ██░░░  7d ████░       (緑 → 黄 → 赤)

 クリック ▼
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

`█` ＝ 残量、`░` ＝ 使った分。上限に近づくほどバーが減り、色が赤くなります。

> 📸 実際のスクリーンショットを `docs/screenshot.png` に置いて、ここで参照してください。

## ✨ 特長

- **電池式ゲージ** — `█` が残量、`░` が使った分。使うほどバーが減っていきます。
- **色分け** — 上限に近づくと **緑 → 黄 → 赤** に変化（別アイコン不要）。
- **コンパクト** — メニューバーはバーだけ。`% left`（残量）とリセットまでの時間はクリックで開くドロップダウンに。
- **レート制限に強い** — 直近の正常値をキャッシュし、API呼び出しを間引き（最短3分間隔）。一時的な `429` でも最後の値を表示。
- **更新通知つき** — 1日1回 GitHub の最新リリースを確認し、新しい版があればドロップダウンに「⬆️ Update available」を表示。
- **ビルド不要・純Bash。** 読みやすく改造も簡単。プライバシー重視。

## 🎨 色のしくみ

バーの色は、**より逼迫している方の枠**が上限にどれだけ近いかを表します:

| 使用率 | 色 | 意味 |
|------:|:-----:|:--------|
| `0–69%`  | 🟢 緑 | 余裕あり |
| `70–89%` | 🟡 黄 | 注意 |
| `90–100%`| 🔴 赤 | ほぼ上限 |

> SwiftBar はメニューバー項目を1色でしか塗れないため、メニューバーのバーは「厳しい方の枠」の色になります。ドロップダウンでは枠ごとに色付けされます。

## 📦 必要なもの

- **macOS** と [SwiftBar](https://github.com/swiftbar/SwiftBar)（または [xbar](https://github.com/matryer/xbar)）
- **jq** と **curl**（curl は macOS 標準搭載／jq は `brew install jq`）
- この Mac に **Claude Code** でサインイン済みであること（Keychain から OAuth トークンを読みます）

## 🚀 インストール

### かんたんインストール（1行）

```bash
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/install.sh | bash
```

jq と SwiftBar を Homebrew で導入し、プラグインを配置して SwiftBar を起動します。初回の Keychain 確認は **「常に許可」** を押してください。

> [Homebrew](https://brew.sh) と、この Mac で **Claude Code** にサインイン済みであることが必要です。

### 手動インストール

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

> ファイル名の `.60s.` は**メニューバーの再描画**が60秒ごとという意味です。API自体は `MIN_INTERVAL` 秒（既定180）に1回しか呼びません。

## ⚙️ 設定

`claude-usage.60s.sh` の冒頭ブロックを編集します:

| 変数 | 既定値 | 役割 |
|---|---|---|
| `WARN` / `DANGER` | `70` / `90` | バーが黄 / 赤になる使用率(%) |
| `OK_COLOR` / `WARN_COLOR` / `DANGER_COLOR` | セージ / オーカー / ブリック | 3色 |
| `FILL` / `EMPTY` | `█` / `░` | 残量 / 使った分のバー文字 |
| `MBAR_W` / `DROP_W` | `5` / `10` | バーの幅（メニューバー / ドロップダウン） |
| `MIN_INTERVAL` | `180` | API呼び出しの最短間隔(秒)。レート制限対策 |
| `SCALE` | `no` | `utilization` の解釈 — エンドポイントは0–100%を返すため `no`（そのまま使用） |
| `UPDATE_CHECK` | `1` | 1日1回 GitHub の新リリースを確認（`0` で無効） |

## 🩺 トラブルシューティング

| 表示 | 意味 | 対処 |
|---|---|---|
| `Claude …` | レート制限中／起動直後 | 何もしなくてOK。数分で自動復帰します |
| `Claude ⚠` | 資格情報が見つからない | Claude Code でサインイン |
| `Claude !` | API が 200 以外を返した | ドロップダウンでステータスコード／本文を確認 |

## 🔒 プライバシーと免責

このプラグインは、お使いの Mac にあるトークンを使って **`api.anthropic.com` だけ** と通信します。それ以外へは何も送信しません。直近の値は `~/.cache/claude-usage-barometer.tsv` にローカル保存されます。

利用しているのは **非公式** の使用量エンドポイント（`/api/oauth/usage`）で、Anthropic 側の都合でいつでも変更・廃止される可能性があります。動かなくなった場合はタイトルに `Claude !` が出ます。PR 歓迎です。

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
