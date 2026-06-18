<div align="center">

#### 🌐 &nbsp; Language · 言語 · Idioma · اللغة · Langue · Sprache

[![English](https://img.shields.io/badge/English-555555?style=for-the-badge)](README.md)
[![日本語](https://img.shields.io/badge/%E6%97%A5%E6%9C%AC%E8%AA%9E-555555?style=for-the-badge)](README.ja.md)
[![Español](https://img.shields.io/badge/Espa%C3%B1ol-2563EB?style=for-the-badge)](README.es.md)
[![العربية](https://img.shields.io/badge/%D8%A7%D9%84%D8%B9%D8%B1%D8%A8%D9%8A%D8%A9-555555?style=for-the-badge)](README.ar.md)
[![Français](https://img.shields.io/badge/Fran%C3%A7ais-555555?style=for-the-badge)](README.fr.md)
[![Deutsch](https://img.shields.io/badge/Deutsch-555555?style=for-the-badge)](README.de.md)

</div>

<div align="center">

# 🎚️ Claude Usage Barometer

**Un medidor compacto estilo batería para la barra de menús que muestra tus límites de uso de Claude.**
Observa cómo se vacían tus ventanas de **5 horas** y **7 días** en tiempo real — directamente desde la barra de menús de macOS.

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

## ⚡ Inicio rápido

**Pega esta única línea en la Terminal — esa es toda la configuración:**

```bash
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/install.sh | bash
```

Instala `jq` + SwiftBar (mediante Homebrew), coloca el plugin y lo inicia. En la primera ejecución, haz clic en **Always Allow** en el aviso del Llavero. _Requiere [Homebrew](https://brew.sh) y que hayas iniciado sesión en Claude Code en este Mac._

---

## 👀 Vista previa

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

`█` = restante, `░` = consumido. La barra se vacía y se enrojece a medida que te acercas al límite.

> 📸 Coloca una captura de pantalla real en `docs/screenshot.png` y haz referencia a ella aquí.

## ✨ Características

- **Medidor estilo batería** — `█` muestra lo que queda, `░` lo que se ha usado; se vacía a medida que consumes tu cuota.
- **Codificado por colores** — la barra se tiñe de **green → amber → red** a medida que te acercas al límite (no hace falta un icono aparte).
- **Compacto** — solo las dos barras en la barra de menús; el menú desplegable muestra `% left` y la cuenta atrás hasta el reinicio.
- **Respetuoso con los límites de tasa** — almacena en caché la última lectura válida y limita las llamadas a la API (separadas ≥ 3 min), sobreviviendo a breves `429`s.
- **Consciente de las actualizaciones** — comprueba GitHub una vez al día y muestra un enlace de "actualización disponible" en el menú desplegable cuando existe una versión más reciente.
- **Frecuencia de actualización ajustable** — elige **1 / 3 / 5 min** en el menú desplegable (el intervalo actual se muestra como `⏱ Update every N min`).
- **Sin compilación, Bash puro.** Fácil de leer, auditar y modificar. Privado por diseño.

## 🎨 Cómo funciona el color

El color de la barra refleja cuán cerca está del límite la ventana **más restringida**:

| Usado | Color | Significado |
|-----:|:-----:|:--------|
| `0–69%`  | 🟢 verde | Queda de sobra |
| `70–89%` | 🟡 ámbar | Acercándose |
| `90–100%`| 🔴 rojo  | Casi agotado |

> SwiftBar pinta cada elemento de la barra de menús de un solo color, así que la barra de la barra de menús usa la peor de las dos ventanas. El menú desplegable tiñe cada ventana de forma individual.

## 📦 Requisitos

- **macOS** con [SwiftBar](https://github.com/swiftbar/SwiftBar) (o [xbar](https://github.com/matryer/xbar))
- **jq** y **curl** (curl viene incluido con macOS; instala jq con `brew install jq`)
- **Claude Code** con sesión iniciada en este Mac — el plugin lee su token OAuth desde tu Llavero

## 🚀 Instalación

### Instalación rápida (una línea)

```bash
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/install.sh | bash
```

Instala `jq` + SwiftBar mediante Homebrew, coloca el plugin e inicia SwiftBar. En la primera ejecución, haz clic en **Always Allow** en el aviso del Llavero.

> Requiere [Homebrew](https://brew.sh) y que hayas iniciado sesión en **Claude Code** en este Mac.

### Instalación manual

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

Luego inicia SwiftBar y apunta su **carpeta de plugins** a `~/SwiftBar`. La primera vez que se ejecuta el plugin, macOS pide acceder a *"Claude Code-credentials"* en tu Llavero — haz clic en **Always Allow**.

> El `.60s.` en el nombre del archivo significa que la barra de menús **se redibuja** cada 60 segundos; la API en sí solo se llama cada `MIN_INTERVAL` segundos (180 por defecto).

## ⚙️ Configuración

Edita el bloque al principio de `claude-usage.60s.sh`:

| Variable | Por defecto | Qué hace |
|---|---|---|
| `WARN` / `DANGER` | `70` / `90` | % usado que pone la barra en ámbar / rojo |
| `OK_COLOR` / `WARN_COLOR` / `DANGER_COLOR` | salvia / ocre / ladrillo | los tres colores |
| `FILL` / `EMPTY` | `█` / `░` | caracteres de barra restante / consumido |
| `MBAR_W` / `DROP_W` | `5` / `10` | ancho de la barra (barra de menús / desplegable) |
| intervalo de actualización | menú | elige **1 / 3 / 5 min** en el desplegable `⏱` (se guarda en `~/.cache/claude-usage-barometer.interval`) |
| `SCALE` | `no` | cómo interpretar `utilization` — el endpoint devuelve porcentajes de 0–100 (`no` = tal cual) |
| `UPDATE_CHECK` | `1` | comprueba GitHub una vez al día en busca de una versión más reciente (`0` para desactivar) |

## 🩺 Resolución de problemas

| Título | Significado | Solución |
|---|---|---|
| `Claude …` | Límite de tasa alcanzado / calentando | Nada — reintenta automáticamente cada pocos minutos |
| `Claude ⚠` | No se encontraron credenciales | Inicia sesión con Claude Code |
| `Claude !` | La API devolvió un código distinto de 200 | Abre el menú desplegable para ver el código de estado / el cuerpo |

## 🔒 Privacidad y descargo de responsabilidad

Este plugin se comunica **únicamente** con `api.anthropic.com`, usando el token que ya está en tu máquina. No se envía nada a ningún otro lugar. La última lectura se almacena en caché localmente en `~/.cache/claude-usage-barometer.tsv`.

Depende de un endpoint de uso **no oficial** (`/api/oauth/usage`) que Anthropic puede cambiar o eliminar en cualquier momento. Si alguna vez deja de funcionar, el título muestra `Claude !`. Se agradecen los PRs.

## 🧰 Pila tecnológica

| Insignia | Función |
|---|---|
| ![Bash](https://img.shields.io/badge/Bash-4EAA25?logo=gnubash&logoColor=white) | Entorno de ejecución del plugin (~90 líneas) |
| ![jq](https://img.shields.io/badge/jq-1E88E5?logo=json&logoColor=white) | Analiza la respuesta JSON |
| ![cURL](https://img.shields.io/badge/cURL-073551?logo=curl&logoColor=white) | Llama a la API de uso |
| ![SwiftBar](https://img.shields.io/badge/SwiftBar-F05138?logo=swift&logoColor=white) | Renderiza en la barra de menús |
| ![macOS](https://img.shields.io/badge/macOS-000000?logo=apple&logoColor=white) | Llavero + host de la barra de menús |
| ![Claude](https://img.shields.io/badge/Claude_API-D97757?logo=anthropic&logoColor=white) | Fuente de los datos de uso |

## 📄 Licencia

[MIT](LICENSE) © 2026 Takayuki Miyano · Atlas Associates Inc.
