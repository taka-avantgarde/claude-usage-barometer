<img src="https://img.shields.io/badge/macOS_%EC%A0%84%EC%9A%A9-007AFF?style=for-the-badge&logo=apple&logoColor=white" height="40" alt="macOS 전용">

<div align="center">

#### 🌐 &nbsp; Language

🇬🇧 [English](README.md) • 🇯🇵 [日本語](README.ja.md) • 🇪🇸 [Español](README.es.md) • 🇸🇦 [العربية](README.ar.md) • 🇫🇷 [Français](README.fr.md) • 🇩🇪 [Deutsch](README.de.md) • 🇨🇳 [简体中文](README.zh.md) • 🇰🇷 **한국어** • 🇧🇷 [Português](README.pt.md) • 🇳🇱 [Nederlands](README.nl.md) • 🇮🇹 [Italiano](README.it.md) • 🇻🇳 [Tiếng Việt](README.vi.md) • 🇮🇩 [Bahasa Indonesia](README.id.md) • 🇹🇭 [ไทย](README.th.md)

</div>

<div align="center">

# 🎚️ Claude Usage Barometer

**Claude 사용량 한도를 위한 컴팩트한 배터리 스타일 메뉴 바 게이지.**
**5시간** 및 **7일** 창이 실시간으로 줄어드는 것을 macOS 메뉴 바에서 바로 확인하세요.

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

## ⚡ 빠른 시작

**이 한 줄을 터미널에 붙여넣으세요 — 그게 설정의 전부입니다:**

```bash
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/install.sh | bash
```

이 명령은 (Homebrew를 통해) `jq` + SwiftBar를 설치하고, 플러그인을 넣은 뒤 실행합니다. 첫 실행 시 키체인 프롬프트에서 **항상 허용**을 클릭하세요. _[Homebrew](https://brew.sh)가 필요하며, 이 Mac에서 Claude Code에 로그인되어 있어야 합니다._

---

## 👀 미리보기

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

`█` = 남은 양, `░` = 사용한 양. 한도에 가까워질수록 막대가 줄어들고 붉어집니다.

> 📸 `docs/screenshot.png`에 실제 스크린샷을 넣고 여기에서 참조하세요.

## ✨ 기능

- **배터리 스타일 게이지** — `█`는 남은 양을, `░`는 사용한 양을 나타내며, 할당량을 소비할수록 줄어듭니다.
- **색상 코드** — 한도에 가까워질수록 막대가 **초록 → 호박색 → 빨강**으로 물듭니다 (별도 아이콘 불필요).
- **컴팩트** — 메뉴 바에는 두 개의 막대만 표시되며, 드롭다운에는 `% left`와 리셋 카운트다운이 나타납니다.
- **속도 제한 친화적** — 마지막 정상 측정값을 캐시하고 API 호출을 (≥ 3분 간격으로) 제한하여 잠깐의 `429`에도 견딥니다.
- **업데이트 인지** — 하루에 한 번 GitHub를 확인하고, 더 새로운 릴리스가 있을 때 드롭다운에 "update available" 링크를 표시합니다.
- **조정 가능한 갱신 주기** — 드롭다운에서 **1 / 3 / 5분**을 선택하세요 (현재 간격은 `⏱ Update every N min`으로 표시됩니다).
- **빌드 없음, 순수 Bash.** 읽고, 감사하고, 수정하기 쉽습니다. 설계상 비공개.

## 🎨 색상이 작동하는 방식

막대의 색상은 **더 제약이 큰** 창이 한도에 얼마나 가까운지를 반영합니다:

| Used | Color | Meaning |
|-----:|:-----:|:--------|
| `0–69%`  | 🟢 초록 | 여유가 충분함 |
| `70–89%` | 🟡 호박색 | 가까워지는 중 |
| `90–100%`| 🔴 빨강   | 거의 소진됨 |

> SwiftBar는 각 메뉴 바 항목을 하나의 색상으로만 칠하므로, 메뉴 바 막대는 두 창 중 더 나쁜 쪽을 사용합니다. 드롭다운은 각 창을 개별적으로 물들입니다.

## 📦 요구 사항

- [SwiftBar](https://github.com/swiftbar/SwiftBar)(또는 [xbar](https://github.com/matryer/xbar))가 설치된 **macOS**
- **jq**와 **curl** (curl은 macOS에 기본 포함되며, jq는 `brew install jq`로 설치)
- 이 Mac에서 로그인된 **Claude Code** — 플러그인이 키체인에서 OAuth 토큰을 읽어옵니다

## 🚀 설치

### 빠른 설치 (한 줄)

```bash
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/install.sh | bash
```

Homebrew를 통해 `jq` + SwiftBar를 설치하고, 플러그인을 넣은 뒤 SwiftBar를 실행합니다. 첫 실행 시 키체인 프롬프트에서 **항상 허용**을 클릭하세요.

> [Homebrew](https://brew.sh)가 필요하며, 이 Mac에서 **Claude Code**에 로그인되어 있어야 합니다.

### 수동 설치

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

그런 다음 SwiftBar를 실행하고 **플러그인 폴더**를 `~/SwiftBar`로 지정하세요. 플러그인이 처음 실행될 때 macOS가 키체인의 *"Claude Code-credentials"* 접근을 요청합니다 — **항상 허용**을 클릭하세요.

> 파일 이름의 `.60s.`는 메뉴 바가 60초마다 **다시 그려진다**는 의미입니다. API 자체는 `MIN_INTERVAL`초(기본값 180)마다만 호출됩니다.

## ⚙️ 구성

`claude-usage.60s.sh` 상단의 블록을 편집하세요:

| Variable | Default | What it does |
|---|---|---|
| `WARN` / `DANGER` | `70` / `90` | 막대를 호박색 / 빨강으로 바꾸는 사용 % |
| `OK_COLOR` / `WARN_COLOR` / `DANGER_COLOR` | sage / ochre / brick | 세 가지 색상 |
| `FILL` / `EMPTY` | `█` / `░` | 남은 양 / 사용한 양 막대 문자 |
| `MBAR_W` / `DROP_W` | `5` / `10` | 막대 너비 (메뉴 바 / 드롭다운) |
| refresh interval | menu | 드롭다운 `⏱`에서 **1 / 3 / 5분**을 선택 (`~/.cache/claude-usage-barometer.interval`에 저장됨) |
| `SCALE` | `no` | `utilization`을 읽는 방식 — 엔드포인트는 0–100 백분율을 반환합니다 (`no` = 있는 그대로) |
| `UPDATE_CHECK` | `1` | 하루에 한 번 GitHub에서 더 새로운 릴리스를 확인 (`0`이면 비활성화) |

## 🩺 문제 해결

| Title | Meaning | Fix |
|---|---|---|
| `Claude …` | 속도 제한 / 준비 중 | 할 일 없음 — 몇 분마다 자동으로 재시도합니다 |
| `Claude ⚠` | 자격 증명을 찾을 수 없음 | Claude Code로 로그인하세요 |
| `Claude !` | API가 비-200을 반환함 | 드롭다운을 열어 상태 코드 / 본문을 확인하세요 |

## 🔒 개인정보 및 면책 조항

이 플러그인은 이미 기기에 있는 토큰을 사용하여 **오직** `api.anthropic.com`하고만 통신합니다. 그 외 어디로도 아무것도 전송되지 않습니다. 마지막 측정값은 `~/.cache/claude-usage-barometer.tsv`에 로컬로 캐시됩니다.

이 플러그인은 Anthropic이 언제든 변경하거나 제거할 수 있는 **비공식** 사용량 엔드포인트(`/api/oauth/usage`)에 의존합니다. 만약 작동이 중단되면 제목에 `Claude !`가 표시됩니다. PR 환영합니다.

## 🧰 기술 스택

| Badge | Role |
|---|---|
| ![Bash](https://img.shields.io/badge/Bash-4EAA25?logo=gnubash&logoColor=white) | 플러그인 런타임 (~90줄) |
| ![jq](https://img.shields.io/badge/jq-1E88E5?logo=json&logoColor=white) | JSON 응답 파싱 |
| ![cURL](https://img.shields.io/badge/cURL-073551?logo=curl&logoColor=white) | 사용량 API 호출 |
| ![SwiftBar](https://img.shields.io/badge/SwiftBar-F05138?logo=swift&logoColor=white) | 메뉴 바에 렌더링 |
| ![macOS](https://img.shields.io/badge/macOS-000000?logo=apple&logoColor=white) | 키체인 + 메뉴 바 호스트 |
| ![Claude](https://img.shields.io/badge/Claude_API-D97757?logo=anthropic&logoColor=white) | 사용량 데이터 출처 |

## 📄 라이선스

[MIT](LICENSE) © 2026 Takayuki Miyano · Atlas Associates Inc.
