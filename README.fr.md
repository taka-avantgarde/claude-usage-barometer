<img src="https://img.shields.io/badge/macOS_uniquement-007AFF?style=for-the-badge&logo=apple&logoColor=white" height="40" alt="macOS uniquement">

<div align="center">

🇬🇧 [English](README.md) • 🇯🇵 [日本語](README.ja.md) • 🇪🇸 [Español](README.es.md) • 🇸🇦 [العربية](README.ar.md) • 🇫🇷 **Français** • 🇩🇪 [Deutsch](README.de.md) • 🇨🇳 [简体中文](README.zh.md) • 🇰🇷 [한국어](README.ko.md) • 🇧🇷 [Português](README.pt.md) • 🇳🇱 [Nederlands](README.nl.md) • 🇮🇹 [Italiano](README.it.md) • 🇻🇳 [Tiếng Việt](README.vi.md) • 🇮🇩 [Bahasa Indonesia](README.id.md) • 🇹🇭 [ไทย](README.th.md)

</div>

<div align="center">

# 🎚️ Claude Usage Barometer

**Une jauge compacte de type batterie pour votre barre de menus, dédiée à vos limites d'utilisation de Claude.**
Regardez vos fenêtres de **5 heures** et **7 jours** se vider en temps réel — directement depuis la barre de menus de macOS.

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

## ⚡ Démarrage rapide

**Collez cette seule ligne dans le Terminal — c'est toute l'installation :**

```bash
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/install.sh | bash
```

Cela installe `jq` + SwiftBar (via Homebrew), met en place le plugin et le lance. Au premier lancement, cliquez sur **Toujours autoriser** pour l'invite du Trousseau. _Nécessite [Homebrew](https://brew.sh) et que vous soyez connecté à Claude Code sur ce Mac._

---

## 👀 Aperçu

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

`█` = restant, `░` = consommé. La barre se vide et rougit à mesure que vous approchez de la limite.

> 📸 Déposez une vraie capture d'écran à `docs/screenshot.png` et référencez-la ici.

## ✨ Fonctionnalités

- **Jauge de type batterie** — `█` indique ce qu'il reste, `░` ce qui est consommé ; elle se vide à mesure que vous utilisez votre quota.
- **Code couleur** — la barre passe du **vert à l'ambre puis au rouge** à mesure que vous approchez de la limite (aucune icône distincte nécessaire).
- **Compacte** — uniquement les deux barres dans la barre de menus ; le menu déroulant affiche le `% left` et le compte à rebours avant réinitialisation.
- **Respectueuse des limites de débit** — met en cache la dernière lecture valide et limite les appels API (espacés d'au moins 3 min), survivant à de brefs `429`.
- **Attentive aux mises à jour** — vérifie GitHub une fois par jour et affiche un lien « mise à jour disponible » dans le menu déroulant lorsqu'une version plus récente existe.
- **Rafraîchissement réglable** — choisissez **1 / 3 / 5 min** depuis le menu déroulant (l'intervalle actuel est affiché sous la forme `⏱ Update every N min`).
- **Aucune compilation, du pur Bash.** Facile à lire, à auditer et à modifier. Privé par conception.

## 🎨 Comment fonctionne la couleur

La couleur de la barre reflète à quel point la fenêtre **la plus contrainte** est proche de sa limite :

| Used | Color | Meaning |
|-----:|:-----:|:--------|
| `0–69%`  | 🟢 vert | Beaucoup de marge |
| `70–89%` | 🟡 ambre | On s'approche |
| `90–100%`| 🔴 rouge   | Presque épuisé |

> SwiftBar peint chaque élément de la barre de menus d'une seule couleur, donc la barre de la barre de menus utilise la pire des deux fenêtres. Le menu déroulant teinte chaque fenêtre individuellement.

## 📦 Prérequis

- **macOS** avec [SwiftBar](https://github.com/swiftbar/SwiftBar) (ou [xbar](https://github.com/matryer/xbar))
- **jq** et **curl** (curl est fourni avec macOS ; installez jq via `brew install jq`)
- **Claude Code** connecté sur ce Mac — le plugin lit son jeton OAuth depuis votre Trousseau

## 🚀 Installation

### Installation rapide (une ligne)

```bash
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/install.sh | bash
```

Installe `jq` + SwiftBar via Homebrew, met en place le plugin et lance SwiftBar. Au premier lancement, cliquez sur **Toujours autoriser** pour l'invite du Trousseau.

> Nécessite [Homebrew](https://brew.sh) et que vous soyez connecté à **Claude Code** sur ce Mac.

### Installation manuelle

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

Lancez ensuite SwiftBar et pointez son **dossier de plugins** vers `~/SwiftBar`. La première fois que le plugin s'exécute, macOS demande l'accès à *« Claude Code-credentials »* dans votre Trousseau — cliquez sur **Toujours autoriser**.

> Le `.60s.` dans le nom de fichier signifie que la barre de menus se **redessine** toutes les 60 secondes ; l'API elle-même n'est appelée que toutes les `MIN_INTERVAL` secondes (180 par défaut).

## ⚙️ Configuration

Modifiez le bloc en haut de `claude-usage.60s.sh` :

| Variable | Default | What it does |
|---|---|---|
| `WARN` / `DANGER` | `70` / `90` | % consommé qui fait passer la barre à l'ambre / au rouge |
| `OK_COLOR` / `WARN_COLOR` / `DANGER_COLOR` | sauge / ocre / brique | les trois couleurs |
| `FILL` / `EMPTY` | `█` / `░` | caractères de barre restant / consommé |
| `MBAR_W` / `DROP_W` | `5` / `10` | largeur de la barre (barre de menus / menu déroulant) |
| refresh interval | menu | choisissez **1 / 3 / 5 min** depuis le `⏱` du menu déroulant (stocké dans `~/.cache/claude-usage-barometer.interval`) |
| `SCALE` | `no` | comment lire `utilization` — le point de terminaison renvoie des pourcentages de 0 à 100 (`no` = tel quel) |
| `UPDATE_CHECK` | `1` | vérifier GitHub une fois par jour pour une version plus récente (`0` pour désactiver) |

## 🩺 Dépannage

| Title | Meaning | Fix |
|---|---|---|
| `Claude …` | Limite de débit atteinte / en cours de démarrage | Rien — il réessaie automatiquement toutes les quelques minutes |
| `Claude ⚠` | Aucune information d'identification trouvée | Connectez-vous avec Claude Code |
| `Claude !` | L'API a renvoyé un statut différent de 200 | Ouvrez le menu déroulant pour le code de statut / le corps de la réponse |

## 🔒 Confidentialité et avertissement

Ce plugin communique **uniquement** avec `api.anthropic.com`, en utilisant le jeton déjà présent sur votre machine. Rien n'est envoyé ailleurs. La dernière lecture est mise en cache localement à `~/.cache/claude-usage-barometer.tsv`.

Il repose sur un point de terminaison d'utilisation **non officiel** (`/api/oauth/usage`) qu'Anthropic peut modifier ou supprimer à tout moment. S'il venait à cesser de fonctionner, le titre affiche `Claude !`. Les PR sont les bienvenues.

## 🧰 Pile technique

| Badge | Role |
|---|---|
| ![Bash](https://img.shields.io/badge/Bash-4EAA25?logo=gnubash&logoColor=white) | Environnement d'exécution du plugin (~90 lignes) |
| ![jq](https://img.shields.io/badge/jq-1E88E5?logo=json&logoColor=white) | Analyse la réponse JSON |
| ![cURL](https://img.shields.io/badge/cURL-073551?logo=curl&logoColor=white) | Appelle l'API d'utilisation |
| ![SwiftBar](https://img.shields.io/badge/SwiftBar-F05138?logo=swift&logoColor=white) | Rendu dans la barre de menus |
| ![macOS](https://img.shields.io/badge/macOS-000000?logo=apple&logoColor=white) | Trousseau + hôte de la barre de menus |
| ![Claude](https://img.shields.io/badge/Claude_API-D97757?logo=anthropic&logoColor=white) | Source des données d'utilisation |

## 📄 Licence

[MIT](LICENSE) © 2026 Takayuki Miyano · Atlas Associates Inc.
