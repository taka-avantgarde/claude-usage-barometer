<img src="https://img.shields.io/badge/Alleen_macOS-007AFF?style=for-the-badge&logo=apple&logoColor=white" height="40" alt="Alleen macOS">

<div align="center">

#### 🌐 &nbsp; Language

🇬🇧 [English](README.md) • 🇯🇵 [日本語](README.ja.md) • 🇪🇸 [Español](README.es.md) • 🇸🇦 [العربية](README.ar.md) • 🇫🇷 [Français](README.fr.md) • 🇩🇪 [Deutsch](README.de.md) • 🇨🇳 [简体中文](README.zh.md) • 🇰🇷 [한국어](README.ko.md) • 🇧🇷 [Português](README.pt.md) • 🇳🇱 **Nederlands** • 🇮🇹 [Italiano](README.it.md) • 🇻🇳 [Tiếng Việt](README.vi.md) • 🇮🇩 [Bahasa Indonesia](README.id.md) • 🇹🇭 [ไทย](README.th.md)

</div>

<div align="center">

# 🎚️ Claude Usage Barometer

**Een compacte meter in batterijstijl in de menubalk voor je Claude-gebruikslimieten.**
Zie je vensters van **5 uur** en **7 dagen** in realtime leeglopen — rechtstreeks vanuit de macOS-menubalk.

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

## ⚡ Snelstart

**Plak deze ene regel in Terminal — dat is de hele installatie:**

```bash
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/install.sh | bash
```

Het installeert `jq` + SwiftBar (via Homebrew), zet de plug-in erin en start die. Klik bij de eerste keer uitvoeren op **Always Allow** bij de Sleutelhanger-prompt. _Vereist [Homebrew](https://brew.sh) en dat je op deze Mac bent aangemeld bij Claude Code._

---

## 👀 Voorbeeld

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

`█` = resterend, `░` = verbruikt. De balk loopt leeg en wordt roder naarmate je de limiet nadert.

> 📸 Zet een echte schermafbeelding op `docs/screenshot.png` en verwijs er hier naar.

## ✨ Functies

- **Meter in batterijstijl** — `█` toont wat er over is, `░` wat verbruikt is; hij loopt leeg naarmate je je quotum verbruikt.
- **Kleurgecodeerd** — de balk wordt getint **groen → amber → rood** naarmate je de limiet nadert (geen apart pictogram nodig).
- **Compact** — alleen de twee balken in de menubalk; het uitklapmenu toont `% left` en de afteltimer tot de reset.
- **Vriendelijk voor rate limits** — bewaart de laatste goede meting in de cache en knijpt API-aanroepen af (≥ 3 min ertussen), zodat het korte `429`s overleeft.
- **Update-bewust** — controleert GitHub eenmaal per dag en toont een "update available"-link in het uitklapmenu wanneer er een nieuwere release bestaat.
- **Aanpasbare verversing** — kies **1 / 3 / 5 min** in het uitklapmenu (het huidige interval wordt getoond als `⏱ Update every N min`).
- **Zero build, pure Bash.** Eenvoudig te lezen, te auditen en aan te passen. Privé van ontwerp.

## 🎨 Hoe de kleur werkt

De kleur van de balk weerspiegelt hoe dicht het **meer-beperkte** venster bij zijn limiet zit:

| Used | Color | Meaning |
|-----:|:-----:|:--------|
| `0–69%`  | 🟢 groen | Genoeg over |
| `70–89%` | 🟡 amber | Komt dichterbij |
| `90–100%`| 🔴 rood   | Bijna op |

> SwiftBar kleurt elk menubalk-item met één enkele kleur, dus de menubalk-balk gebruikt de slechtste van de twee vensters. Het uitklapmenu tint elk venster afzonderlijk.

## 📦 Vereisten

- **macOS** met [SwiftBar](https://github.com/swiftbar/SwiftBar) (of [xbar](https://github.com/matryer/xbar))
- **jq** en **curl** (curl wordt met macOS meegeleverd; installeer jq via `brew install jq`)
- **Claude Code** aangemeld op deze Mac — de plug-in leest het OAuth-token uit je Sleutelhanger

## 🚀 Installatie

### Snelle installatie (één regel)

```bash
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/install.sh | bash
```

Installeert `jq` + SwiftBar via Homebrew, zet de plug-in erin en start SwiftBar. Klik bij de eerste keer uitvoeren op **Always Allow** bij de Sleutelhanger-prompt.

> Vereist [Homebrew](https://brew.sh) en dat je op deze Mac bent aangemeld bij **Claude Code**.

### Handmatige installatie

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

Start daarna SwiftBar en wijs de **plugin folder** naar `~/SwiftBar`. De eerste keer dat de plug-in draait, vraagt macOS om toegang tot *"Claude Code-credentials"* in je Sleutelhanger — klik op **Always Allow**.

> De `.60s.` in de bestandsnaam betekent dat de menubalk elke 60 seconden **opnieuw wordt getekend**; de API zelf wordt alleen elke `MIN_INTERVAL` seconden aangeroepen (standaard 180).

## ⚙️ Configuratie

Bewerk het blok bovenaan `claude-usage.60s.sh`:

| Variable | Default | What it does |
|---|---|---|
| `WARN` / `DANGER` | `70` / `90` | % verbruikt waarbij de balk amber / rood wordt |
| `OK_COLOR` / `WARN_COLOR` / `DANGER_COLOR` | salie / oker / baksteen | de drie kleuren |
| `FILL` / `EMPTY` | `█` / `░` | balktekens voor resterend / verbruikt |
| `MBAR_W` / `DROP_W` | `5` / `10` | balkbreedte (menubalk / uitklapmenu) |
| refresh interval | menu | kies **1 / 3 / 5 min** in het uitklapmenu `⏱` (opgeslagen in `~/.cache/claude-usage-barometer.interval`) |
| `SCALE` | `no` | hoe `utilization` te lezen — het eindpunt geeft percentages van 0–100 terug (`no` = ongewijzigd) |
| `UPDATE_CHECK` | `1` | controleer GitHub eenmaal per dag op een nieuwere release (`0` om uit te schakelen) |

## 🩺 Probleemoplossing

| Title | Meaning | Fix |
|---|---|---|
| `Claude …` | Rate limited / aan het opwarmen | Niets — het probeert automatisch elke paar minuten opnieuw |
| `Claude ⚠` | Geen inloggegevens gevonden | Meld je aan met Claude Code |
| `Claude !` | API gaf niet-200 terug | Open het uitklapmenu voor de statuscode / body |

## 🔒 Privacy & disclaimer

Deze plug-in communiceert **alleen** met `api.anthropic.com`, met het token dat al op je machine staat. Er wordt niets ergens anders naartoe gestuurd. De laatste meting wordt lokaal in de cache bewaard op `~/.cache/claude-usage-barometer.tsv`.

Het steunt op een **onofficieel** gebruikseindpunt (`/api/oauth/usage`) dat Anthropic op elk moment kan wijzigen of verwijderen. Als het ooit kapot gaat, toont de titel `Claude !`. PRs welkom.

## 🧰 Tech-stack

| Badge | Role |
|---|---|
| ![Bash](https://img.shields.io/badge/Bash-4EAA25?logo=gnubash&logoColor=white) | Plug-in-runtime (~90 regels) |
| ![jq](https://img.shields.io/badge/jq-1E88E5?logo=json&logoColor=white) | De JSON-respons parsen |
| ![cURL](https://img.shields.io/badge/cURL-073551?logo=curl&logoColor=white) | De gebruiks-API aanroepen |
| ![SwiftBar](https://img.shields.io/badge/SwiftBar-F05138?logo=swift&logoColor=white) | Weergeven in de menubalk |
| ![macOS](https://img.shields.io/badge/macOS-000000?logo=apple&logoColor=white) | Sleutelhanger + menubalk-host |
| ![Claude](https://img.shields.io/badge/Claude_API-D97757?logo=anthropic&logoColor=white) | Bron van gebruiksgegevens |

## 📄 Licentie

[MIT](LICENSE) © 2026 Takayuki Miyano · Atlas Associates Inc.
