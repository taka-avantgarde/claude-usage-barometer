<img src="https://img.shields.io/badge/Solo_macOS-007AFF?style=for-the-badge&logo=apple&logoColor=white" height="40" alt="Solo macOS">

<div align="center">

#### 🌐 &nbsp; Language

🇬🇧 [English](README.md) • 🇯🇵 [日本語](README.ja.md) • 🇪🇸 [Español](README.es.md) • 🇸🇦 [العربية](README.ar.md) • 🇫🇷 [Français](README.fr.md) • 🇩🇪 [Deutsch](README.de.md) • 🇨🇳 [简体中文](README.zh.md) • 🇰🇷 [한국어](README.ko.md) • 🇧🇷 [Português](README.pt.md) • 🇳🇱 [Nederlands](README.nl.md) • 🇮🇹 **Italiano** • 🇻🇳 [Tiếng Việt](README.vi.md) • 🇮🇩 [Bahasa Indonesia](README.id.md) • 🇹🇭 [ไทย](README.th.md)

</div>

<div align="center">

# 🎚️ Claude Usage Barometer

**Un indicatore compatto in stile batteria, nella barra dei menu, per i tuoi limiti di utilizzo di Claude.**
Guarda le tue finestre da **5 ore** e **7 giorni** scaricarsi in tempo reale — direttamente dalla barra dei menu di macOS.

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

## ⚡ Avvio rapido

**Incolla questa singola riga nel Terminale — è tutta la configurazione:**

```bash
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/install.sh | bash
```

Installa `jq` + SwiftBar (tramite Homebrew), inserisce il plugin e lo avvia. Al primo avvio, fai clic su **Consenti sempre** per la richiesta del Portachiavi. _Richiede [Homebrew](https://brew.sh) e che tu abbia effettuato l'accesso a Claude Code su questo Mac._

---

## 👀 Anteprima

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

`█` = rimanente, `░` = consumato. La barra si scarica e diventa rossa man mano che ti avvicini al limite.

> 📸 Inserisci uno screenshot reale in `docs/screenshot.png` e riferiscilo qui.

## ✨ Funzionalità

- **Indicatore in stile batteria** — `█` mostra ciò che resta, `░` ciò che è stato usato; si scarica man mano che consumi la tua quota.
- **Codificato a colori** — la barra è colorata **green → amber → red** man mano che ti avvicini al limite (non serve un'icona separata).
- **Compatto** — solo le due barre nella barra dei menu; il menu a discesa mostra `% left` e il conto alla rovescia per il ripristino.
- **Rispettoso dei limiti di frequenza** — memorizza nella cache l'ultima lettura valida e limita le chiamate API (≥ 3 min di distanza), sopravvivendo a brevi `429`.
- **Consapevole degli aggiornamenti** — controlla GitHub una volta al giorno e mostra un link "aggiornamento disponibile" nel menu a discesa quando esiste una versione più recente.
- **Aggiornamento regolabile** — scegli **1 / 3 / 5 min** dal menu a discesa (l'intervallo corrente è mostrato come `⏱ Update every N min`).
- **Zero build, puro Bash.** Facile da leggere, controllare e modificare. Privato per progettazione.

## 🎨 Come funziona il colore

Il colore della barra riflette quanto la finestra **più vincolata** è vicina al suo limite:

| Used | Color | Meaning |
|-----:|:-----:|:--------|
| `0–69%`  | 🟢 verde | Molto disponibile |
| `70–89%` | 🟡 ambra | Ci si avvicina |
| `90–100%`| 🔴 rosso   | Quasi esaurito |

> SwiftBar colora ogni elemento della barra dei menu con un solo colore, quindi la barra nella barra dei menu usa la peggiore delle due finestre. Il menu a discesa colora ogni finestra individualmente.

## 📦 Requisiti

- **macOS** con [SwiftBar](https://github.com/swiftbar/SwiftBar) (o [xbar](https://github.com/matryer/xbar))
- **jq** e **curl** (curl è incluso in macOS; installa jq tramite `brew install jq`)
- **Claude Code** con accesso effettuato su questo Mac — il plugin legge il suo token OAuth dal tuo Portachiavi

## 🚀 Installazione

### Installazione rapida (una riga)

```bash
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/install.sh | bash
```

Installa `jq` + SwiftBar tramite Homebrew, inserisce il plugin e avvia SwiftBar. Al primo avvio, fai clic su **Consenti sempre** per la richiesta del Portachiavi.

> Richiede [Homebrew](https://brew.sh) e che tu abbia effettuato l'accesso a **Claude Code** su questo Mac.

### Installazione manuale

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

Poi avvia SwiftBar e imposta la sua **cartella dei plugin** su `~/SwiftBar`. La prima volta che il plugin viene eseguito, macOS chiede di accedere a *"Claude Code-credentials"* nel tuo Portachiavi — fai clic su **Consenti sempre**.

> Il `.60s.` nel nome del file significa che la barra dei menu **viene ridisegnata** ogni 60 secondi; l'API stessa viene chiamata solo ogni `MIN_INTERVAL` secondi (predefinito 180).

## ⚙️ Configurazione

Modifica il blocco all'inizio di `claude-usage.60s.sh`:

| Variable | Default | What it does |
|---|---|---|
| `WARN` / `DANGER` | `70` / `90` | % usata che rende la barra ambra / rossa |
| `OK_COLOR` / `WARN_COLOR` / `DANGER_COLOR` | salvia / ocra / mattone | i tre colori |
| `FILL` / `EMPTY` | `█` / `░` | caratteri della barra rimanente / consumata |
| `MBAR_W` / `DROP_W` | `5` / `10` | larghezza della barra (barra dei menu / menu a discesa) |
| refresh interval | menu | scegli **1 / 3 / 5 min** dal menu a discesa `⏱` (memorizzato in `~/.cache/claude-usage-barometer.interval`) |
| `SCALE` | `no` | come leggere `utilization` — l'endpoint restituisce percentuali 0–100 (`no` = così com'è) |
| `UPDATE_CHECK` | `1` | controlla GitHub una volta al giorno per una versione più recente (`0` per disabilitare) |

## 🩺 Risoluzione dei problemi

| Title | Meaning | Fix |
|---|---|---|
| `Claude …` | Limite di frequenza / riscaldamento in corso | Niente — riprova automaticamente ogni pochi minuti |
| `Claude ⚠` | Nessuna credenziale trovata | Accedi con Claude Code |
| `Claude !` | L'API ha restituito un valore diverso da 200 | Apri il menu a discesa per il codice di stato / corpo |

## 🔒 Privacy e disclaimer

Questo plugin comunica **solo** con `api.anthropic.com`, usando il token già presente sulla tua macchina. Niente viene inviato altrove. L'ultima lettura è memorizzata nella cache localmente in `~/.cache/claude-usage-barometer.tsv`.

Si basa su un endpoint di utilizzo **non ufficiale** (`/api/oauth/usage`) che Anthropic potrebbe modificare o rimuovere in qualsiasi momento. Se dovesse mai smettere di funzionare, il titolo mostra `Claude !`. Le PR sono benvenute.

## 🧰 Stack tecnologico

| Badge | Role |
|---|---|
| ![Bash](https://img.shields.io/badge/Bash-4EAA25?logo=gnubash&logoColor=white) | Runtime del plugin (~90 righe) |
| ![jq](https://img.shields.io/badge/jq-1E88E5?logo=json&logoColor=white) | Analizza la risposta JSON |
| ![cURL](https://img.shields.io/badge/cURL-073551?logo=curl&logoColor=white) | Chiama l'API di utilizzo |
| ![SwiftBar](https://img.shields.io/badge/SwiftBar-F05138?logo=swift&logoColor=white) | Mostra nella barra dei menu |
| ![macOS](https://img.shields.io/badge/macOS-000000?logo=apple&logoColor=white) | Host del Portachiavi + barra dei menu |
| ![Claude](https://img.shields.io/badge/Claude_API-D97757?logo=anthropic&logoColor=white) | Fonte dei dati di utilizzo |

## 📄 Licenza

[MIT](LICENSE) © 2026 Takayuki Miyano · Atlas Associates Inc.
