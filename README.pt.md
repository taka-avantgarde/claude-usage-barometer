<img src="https://img.shields.io/badge/Somente_macOS-007AFF?style=for-the-badge&logo=apple&logoColor=white" height="40" alt="Somente macOS">

<div align="center">

🇬🇧 [English](README.md) • 🇯🇵 [日本語](README.ja.md) • 🇪🇸 [Español](README.es.md) • 🇸🇦 [العربية](README.ar.md) • 🇫🇷 [Français](README.fr.md) • 🇩🇪 [Deutsch](README.de.md) • 🇨🇳 [简体中文](README.zh.md) • 🇰🇷 [한국어](README.ko.md) • 🇧🇷 **Português** • 🇳🇱 [Nederlands](README.nl.md) • 🇮🇹 [Italiano](README.it.md) • 🇻🇳 [Tiếng Việt](README.vi.md) • 🇮🇩 [Bahasa Indonesia](README.id.md) • 🇹🇭 [ไทย](README.th.md)

</div>

<div align="center">

# 🎚️ Claude Usage Barometer

**Um medidor compacto, em estilo de bateria, na barra de menus para seus limites de uso do Claude.**
Acompanhe suas janelas de **5 horas** e **7 dias** se esgotarem em tempo real — direto da barra de menus do macOS.

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

## ⚡ Início rápido

**Cole esta única linha no Terminal — essa é toda a configuração:**

```bash
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/install.sh | bash
```

Ele instala o `jq` + SwiftBar (via Homebrew), insere o plugin e o inicia. Na primeira execução, clique em **Sempre Permitir** no prompt do Keychain. _Requer o [Homebrew](https://brew.sh) e que você esteja conectado ao Claude Code neste Mac._

---

## 👀 Visualização

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

`█` = restante, `░` = consumido. A barra se esvazia e fica vermelha à medida que você se aproxima do limite.

> 📸 Coloque uma captura de tela real em `docs/screenshot.png` e referencie-a aqui.

## ✨ Recursos

- **Medidor em estilo de bateria** — `█` mostra o que resta, `░` o que foi consumido; ele se esvazia conforme você usa sua cota.
- **Codificado por cores** — a barra é colorida em **verde → âmbar → vermelho** conforme você se aproxima do limite (não é necessário um ícone separado).
- **Compacto** — apenas as duas barras na barra de menus; o menu suspenso mostra `% left` e a contagem regressiva de reinício.
- **Amigável a limites de taxa** — armazena em cache a última leitura válida e limita as chamadas à API (com intervalo ≥ 3 min), sobrevivendo a breves `429`s.
- **Ciente de atualizações** — verifica o GitHub uma vez por dia e mostra um link "atualização disponível" no menu suspenso quando existe uma versão mais recente.
- **Atualização ajustável** — escolha **1 / 3 / 5 min** no menu suspenso (o intervalo atual é mostrado como `⏱ Update every N min`).
- **Zero build, Bash puro.** Fácil de ler, auditar e ajustar. Privado por design.

## 🎨 Como as cores funcionam

A cor da barra reflete o quão perto a janela **mais restrita** está de seu limite:

| Used | Color | Meaning |
|-----:|:-----:|:--------|
| `0–69%`  | 🟢 verde | Muito restante |
| `70–89%` | 🟡 âmbar | Chegando perto |
| `90–100%`| 🔴 vermelho   | Quase esgotado |

> O SwiftBar pinta cada item da barra de menus com uma única cor, então a barra na barra de menus usa a pior das duas janelas. O menu suspenso colore cada janela individualmente.

## 📦 Requisitos

- **macOS** com [SwiftBar](https://github.com/swiftbar/SwiftBar) (ou [xbar](https://github.com/matryer/xbar))
- **jq** e **curl** (o curl vem com o macOS; instale o jq via `brew install jq`)
- **Claude Code** conectado neste Mac — o plugin lê o token OAuth dele do seu Keychain

## 🚀 Instalação

### Instalação rápida (uma linha)

```bash
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/install.sh | bash
```

Instala o `jq` + SwiftBar via Homebrew, insere o plugin e inicia o SwiftBar. Na primeira execução, clique em **Sempre Permitir** no prompt do Keychain.

> Requer o [Homebrew](https://brew.sh) e que você esteja conectado ao **Claude Code** neste Mac.

### Instalação manual

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

Em seguida, inicie o SwiftBar e aponte a sua **pasta de plugins** para `~/SwiftBar`. Na primeira vez que o plugin é executado, o macOS pede para acessar *"Claude Code-credentials"* no seu Keychain — clique em **Sempre Permitir**.

> O `.60s.` no nome do arquivo significa que a barra de menus **se redesenha** a cada 60 segundos; a própria API só é chamada a cada `MIN_INTERVAL` segundos (padrão 180).

## ⚙️ Configuração

Edite o bloco no topo de `claude-usage.60s.sh`:

| Variable | Default | What it does |
|---|---|---|
| `WARN` / `DANGER` | `70` / `90` | % usado que torna a barra âmbar / vermelha |
| `OK_COLOR` / `WARN_COLOR` / `DANGER_COLOR` | sage / ochre / brick | as três cores |
| `FILL` / `EMPTY` | `█` / `░` | caracteres de barra restante / consumido |
| `MBAR_W` / `DROP_W` | `5` / `10` | largura da barra (barra de menus / menu suspenso) |
| refresh interval | menu | escolha **1 / 3 / 5 min** no menu suspenso `⏱` (armazenado em `~/.cache/claude-usage-barometer.interval`) |
| `SCALE` | `no` | como ler `utilization` — o endpoint retorna percentagens de 0–100 (`no` = como está) |
| `UPDATE_CHECK` | `1` | verifica o GitHub uma vez por dia em busca de uma versão mais recente (`0` para desativar) |

## 🩺 Solução de problemas

| Title | Meaning | Fix |
|---|---|---|
| `Claude …` | Limite de taxa atingido / aquecendo | Nada — ele tenta novamente automaticamente a cada poucos minutos |
| `Claude ⚠` | Nenhuma credencial encontrada | Conecte-se com o Claude Code |
| `Claude !` | A API retornou um código diferente de 200 | Abra o menu suspenso para ver o código de status / corpo |

## 🔒 Privacidade e isenção de responsabilidade

Este plugin se comunica **apenas** com `api.anthropic.com`, usando o token que já está na sua máquina. Nada é enviado para nenhum outro lugar. A última leitura é armazenada em cache localmente em `~/.cache/claude-usage-barometer.tsv`.

Ele depende de um endpoint de uso **não oficial** (`/api/oauth/usage`) que a Anthropic pode alterar ou remover a qualquer momento. Se ele algum dia parar de funcionar, o título mostra `Claude !`. PRs são bem-vindos.

## 🧰 Pilha de tecnologias

| Badge | Role |
|---|---|
| ![Bash](https://img.shields.io/badge/Bash-4EAA25?logo=gnubash&logoColor=white) | Runtime do plugin (~90 linhas) |
| ![jq](https://img.shields.io/badge/jq-1E88E5?logo=json&logoColor=white) | Analisa a resposta JSON |
| ![cURL](https://img.shields.io/badge/cURL-073551?logo=curl&logoColor=white) | Chama a API de uso |
| ![SwiftBar](https://img.shields.io/badge/SwiftBar-F05138?logo=swift&logoColor=white) | Renderiza na barra de menus |
| ![macOS](https://img.shields.io/badge/macOS-000000?logo=apple&logoColor=white) | Host do Keychain + barra de menus |
| ![Claude](https://img.shields.io/badge/Claude_API-D97757?logo=anthropic&logoColor=white) | Fonte dos dados de uso |

## 📄 Licença

[MIT](LICENSE) © 2026 Takayuki Miyano · Atlas Associates Inc.
