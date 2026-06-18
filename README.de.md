<img src="https://img.shields.io/badge/Nur_macOS-007AFF?style=for-the-badge&logo=apple&logoColor=white" height="40" alt="Nur macOS">

<div align="center">

🇬🇧 [English](README.md) • 🇯🇵 [日本語](README.ja.md) • 🇪🇸 [Español](README.es.md) • 🇸🇦 [العربية](README.ar.md) • 🇫🇷 [Français](README.fr.md) • 🇩🇪 **Deutsch** • 🇨🇳 [简体中文](README.zh.md) • 🇰🇷 [한국어](README.ko.md) • 🇧🇷 [Português](README.pt.md) • 🇳🇱 [Nederlands](README.nl.md) • 🇮🇹 [Italiano](README.it.md) • 🇻🇳 [Tiếng Việt](README.vi.md) • 🇮🇩 [Bahasa Indonesia](README.id.md) • 🇹🇭 [ไทย](README.th.md)

</div>

<div align="center">

# 🎚️ Claude Usage Barometer

**Eine kompakte Menüleisten-Anzeige im Batteriestil für deine Claude-Nutzungslimits.**
Beobachte, wie deine **5-Stunden-** und **7-Tage-**Zeitfenster in Echtzeit leerlaufen — direkt aus der macOS-Menüleiste.

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

## ⚡ Schnellstart

**Füge diese eine Zeile ins Terminal ein — das ist die komplette Einrichtung:**

```bash
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/install.sh | bash
```

Es installiert `jq` + SwiftBar (über Homebrew), legt das Plugin ein und startet es. Klicke beim ersten Start bei der Schlüsselbund-Abfrage auf **Always Allow**. _Setzt [Homebrew](https://brew.sh) voraus sowie dass du auf diesem Mac bei Claude Code angemeldet bist._

---

## 👀 Vorschau

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

`█` = verbleibend, `░` = verbraucht. Der Balken läuft leer und färbt sich rot, je näher du dem Limit kommst.

> 📸 Lege einen echten Screenshot unter `docs/screenshot.png` ab und verweise hier darauf.

## ✨ Funktionen

- **Anzeige im Batteriestil** — `█` zeigt, was übrig ist, `░` was verbraucht wurde; sie läuft leer, während du dein Kontingent aufbrauchst.
- **Farbcodiert** — der Balken wird **grün → gelb → rot** eingefärbt, je näher du dem Limit kommst (kein separates Symbol nötig).
- **Kompakt** — nur die beiden Balken in der Menüleiste; das Dropdown zeigt `% left` und den Countdown bis zum Zurücksetzen.
- **Schonend bei Ratenlimits** — speichert die letzte gültige Messung im Cache und drosselt API-Aufrufe (mindestens 3 Min. Abstand), übersteht kurze `429`s.
- **Update-bewusst** — prüft GitHub einmal täglich und zeigt im Dropdown einen Link "update available" an, wenn eine neuere Version vorliegt.
- **Anpassbare Aktualisierung** — wähle **1 / 3 / 5 min** aus dem Dropdown (das aktuelle Intervall wird als `⏱ Update every N min` angezeigt).
- **Kein Build, reines Bash.** Leicht zu lesen, zu prüfen und anzupassen. Von Grund auf privat.

## 🎨 Wie die Farbgebung funktioniert

Die Farbe des Balkens spiegelt wider, wie nah das **stärker eingeschränkte** Zeitfenster an seinem Limit ist:

| Used | Color | Meaning |
|-----:|:-----:|:--------|
| `0–69%`  | 🟢 grün | Reichlich übrig |
| `70–89%` | 🟡 gelb | Wird knapp |
| `90–100%`| 🔴 rot   | Fast aufgebraucht |

> SwiftBar färbt jedes Menüleisten-Element in einer einzigen Farbe, daher verwendet der Balken in der Menüleiste den schlechteren der beiden Zeitfenster-Werte. Das Dropdown färbt jedes Zeitfenster einzeln ein.

## 📦 Voraussetzungen

- **macOS** mit [SwiftBar](https://github.com/swiftbar/SwiftBar) (oder [xbar](https://github.com/matryer/xbar))
- **jq** und **curl** (curl ist bei macOS dabei; jq über `brew install jq` installieren)
- **Claude Code** auf diesem Mac angemeldet — das Plugin liest dessen OAuth-Token aus deinem Schlüsselbund

## 🚀 Installation

### Schnellinstallation (eine Zeile)

```bash
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/install.sh | bash
```

Installiert `jq` + SwiftBar über Homebrew, legt das Plugin ein und startet SwiftBar. Klicke beim ersten Start bei der Schlüsselbund-Abfrage auf **Always Allow**.

> Setzt [Homebrew](https://brew.sh) voraus sowie dass du auf diesem Mac bei **Claude Code** angemeldet bist.

### Manuelle Installation

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

Starte dann SwiftBar und richte dessen **Plugin-Ordner** auf `~/SwiftBar`. Wenn das Plugin zum ersten Mal läuft, fragt macOS nach Zugriff auf *"Claude Code-credentials"* in deinem Schlüsselbund — klicke auf **Always Allow**.

> Das `.60s.` im Dateinamen bedeutet, dass die Menüleiste alle 60 Sekunden **neu gezeichnet** wird; die API selbst wird nur alle `MIN_INTERVAL` Sekunden aufgerufen (Standard 180).

## ⚙️ Konfiguration

Bearbeite den Block am Anfang von `claude-usage.60s.sh`:

| Variable | Default | What it does |
|---|---|---|
| `WARN` / `DANGER` | `70` / `90` | % verbraucht, ab dem der Balken gelb / rot wird |
| `OK_COLOR` / `WARN_COLOR` / `DANGER_COLOR` | salbei / ocker / ziegelrot | die drei Farben |
| `FILL` / `EMPTY` | `█` / `░` | Balkenzeichen für verbleibend / verbraucht |
| `MBAR_W` / `DROP_W` | `5` / `10` | Balkenbreite (Menüleiste / Dropdown) |
| refresh interval | menu | wähle **1 / 3 / 5 min** aus dem Dropdown `⏱` (gespeichert in `~/.cache/claude-usage-barometer.interval`) |
| `SCALE` | `no` | wie `utilization` zu lesen ist — der Endpunkt liefert Prozentwerte von 0–100 (`no` = unverändert) |
| `UPDATE_CHECK` | `1` | prüft GitHub einmal täglich auf eine neuere Version (`0` zum Deaktivieren) |

## 🩺 Fehlerbehebung

| Title | Meaning | Fix |
|---|---|---|
| `Claude …` | Ratenlimit erreicht / Aufwärmphase | Nichts — es versucht es alle paar Minuten automatisch erneut |
| `Claude ⚠` | Keine Zugangsdaten gefunden | Mit Claude Code anmelden |
| `Claude !` | API hat nicht-200 zurückgegeben | Öffne das Dropdown für den Statuscode / Body |

## 🔒 Datenschutz & Haftungsausschluss

Dieses Plugin kommuniziert **ausschließlich** mit `api.anthropic.com` und verwendet dabei das bereits auf deinem Rechner vorhandene Token. Es wird nichts an irgendeinen anderen Ort gesendet. Die letzte Messung wird lokal unter `~/.cache/claude-usage-barometer.tsv` zwischengespeichert.

Es stützt sich auf einen **inoffiziellen** Nutzungs-Endpunkt (`/api/oauth/usage`), den Anthropic jederzeit ändern oder entfernen kann. Falls er einmal nicht mehr funktioniert, zeigt der Titel `Claude !` an. PRs willkommen.

## 🧰 Tech-Stack

| Badge | Role |
|---|---|
| ![Bash](https://img.shields.io/badge/Bash-4EAA25?logo=gnubash&logoColor=white) | Plugin-Laufzeit (~90 Zeilen) |
| ![jq](https://img.shields.io/badge/jq-1E88E5?logo=json&logoColor=white) | Parst die JSON-Antwort |
| ![cURL](https://img.shields.io/badge/cURL-073551?logo=curl&logoColor=white) | Ruft die Nutzungs-API auf |
| ![SwiftBar](https://img.shields.io/badge/SwiftBar-F05138?logo=swift&logoColor=white) | Stellt in der Menüleiste dar |
| ![macOS](https://img.shields.io/badge/macOS-000000?logo=apple&logoColor=white) | Schlüsselbund + Menüleisten-Host |
| ![Claude](https://img.shields.io/badge/Claude_API-D97757?logo=anthropic&logoColor=white) | Quelle der Nutzungsdaten |

## 📄 Lizenz

[MIT](LICENSE) © 2026 Takayuki Miyano · Atlas Associates Inc.
