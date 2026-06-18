<img src="https://img.shields.io/badge/Hanya_macOS-007AFF?style=for-the-badge&logo=apple&logoColor=white" height="40" alt="Hanya macOS">

<div align="center">

🇬🇧 [English](README.md) • 🇯🇵 [日本語](README.ja.md) • 🇪🇸 [Español](README.es.md) • 🇸🇦 [العربية](README.ar.md) • 🇫🇷 [Français](README.fr.md) • 🇩🇪 [Deutsch](README.de.md) • 🇨🇳 [简体中文](README.zh.md) • 🇰🇷 [한국어](README.ko.md) • 🇧🇷 [Português](README.pt.md) • 🇳🇱 [Nederlands](README.nl.md) • 🇮🇹 [Italiano](README.it.md) • 🇻🇳 [Tiếng Việt](README.vi.md) • 🇮🇩 **Bahasa Indonesia** • 🇹🇭 [ไทย](README.th.md)

</div>

<div align="center">

# 🎚️ Claude Usage Barometer

**Pengukur ringkas bergaya baterai di bilah menu untuk batas penggunaan Claude Anda.**
Pantau jendela **5 jam** dan **7 hari** Anda terkuras secara real-time — langsung dari bilah menu macOS.

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

## ⚡ Mulai cepat

**Tempel satu baris ini ke Terminal — itulah keseluruhan penyiapannya:**

```bash
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/install.sh | bash
```

Ia memasang `jq` + SwiftBar (melalui Homebrew), menempatkan plugin, dan menjalankannya. Pada saat pertama kali dijalankan, klik **Always Allow** untuk perintah Keychain. _Membutuhkan [Homebrew](https://brew.sh) dan Anda sudah masuk ke Claude Code di Mac ini._

---

## 👀 Pratinjau

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

`█` = sisa, `░` = terpakai. Bilah terkuras dan memerah saat Anda mendekati batas.

> 📸 Taruh tangkapan layar asli di `docs/screenshot.png` dan rujuk di sini.

## ✨ Fitur

- **Pengukur bergaya baterai** — `█` menunjukkan sisa, `░` yang terpakai; ia terkuras saat Anda mengonsumsi kuota Anda.
- **Berkode warna** — bilah diberi warna **green → amber → red** saat Anda mendekati batas (tanpa perlu ikon terpisah).
- **Ringkas** — hanya dua bilah di bilah menu; dropdown menampilkan `% left` dan hitung mundur reset.
- **Ramah batas laju** — menyimpan pembacaan baik terakhir dan membatasi panggilan API (≥ 3 menit jarak), bertahan dari `429` singkat.
- **Sadar pembaruan** — memeriksa GitHub sekali sehari dan menampilkan tautan "update available" di dropdown bila rilis yang lebih baru tersedia.
- **Penyegaran yang dapat disesuaikan** — pilih **1 / 3 / 5 min** dari dropdown (interval saat ini ditampilkan sebagai `⏱ Update every N min`).
- **Tanpa build, murni Bash.** Mudah dibaca, diaudit, dan diubah. Privat sejak awal.

## 🎨 Cara kerja warnanya

Warna bilah mencerminkan seberapa dekat jendela yang **lebih terbatas** dengan batasnya:

| Used | Color | Meaning |
|-----:|:-----:|:--------|
| `0–69%`  | 🟢 hijau | Masih banyak sisa |
| `70–89%` | 🟡 kuning | Mulai mendekat |
| `90–100%`| 🔴 merah   | Hampir habis |

> SwiftBar mewarnai setiap item bilah menu dengan satu warna, jadi bilah di bilah menu menggunakan yang terburuk dari kedua jendela. Dropdown mewarnai setiap jendela secara individual.

## 📦 Persyaratan

- **macOS** dengan [SwiftBar](https://github.com/swiftbar/SwiftBar) (atau [xbar](https://github.com/matryer/xbar))
- **jq** dan **curl** (curl sudah ada di macOS; pasang jq melalui `brew install jq`)
- **Claude Code** sudah masuk di Mac ini — plugin membaca token OAuth-nya dari Keychain Anda

## 🚀 Instalasi

### Instalasi cepat (satu baris)

```bash
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/install.sh | bash
```

Memasang `jq` + SwiftBar melalui Homebrew, menempatkan plugin, dan menjalankan SwiftBar. Pada saat pertama kali dijalankan, klik **Always Allow** untuk perintah Keychain.

> Membutuhkan [Homebrew](https://brew.sh) dan Anda sudah masuk ke **Claude Code** di Mac ini.

### Instalasi manual

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

Lalu jalankan SwiftBar dan arahkan **plugin folder**-nya ke `~/SwiftBar`. Pada saat pertama kali plugin berjalan, macOS meminta akses ke *"Claude Code-credentials"* di Keychain Anda — klik **Always Allow**.

> `.60s.` pada nama berkas berarti bilah menu **digambar ulang** setiap 60 detik; API itu sendiri hanya dipanggil setiap `MIN_INTERVAL` detik (default 180).

## ⚙️ Konfigurasi

Sunting blok di bagian atas `claude-usage.60s.sh`:

| Variable | Default | What it does |
|---|---|---|
| `WARN` / `DANGER` | `70` / `90` | % terpakai yang mengubah bilah menjadi kuning / merah |
| `OK_COLOR` / `WARN_COLOR` / `DANGER_COLOR` | sage / ochre / brick | ketiga warna |
| `FILL` / `EMPTY` | `█` / `░` | karakter bilah sisa / terpakai |
| `MBAR_W` / `DROP_W` | `5` / `10` | lebar bilah (bilah menu / dropdown) |
| refresh interval | menu | pilih **1 / 3 / 5 min** dari dropdown `⏱` (disimpan di `~/.cache/claude-usage-barometer.interval`) |
| `SCALE` | `no` | cara membaca `utilization` — endpoint mengembalikan persentase 0–100 (`no` = apa adanya) |
| `UPDATE_CHECK` | `1` | periksa GitHub sekali sehari untuk rilis yang lebih baru (`0` untuk menonaktifkan) |

## 🩺 Pemecahan masalah

| Title | Meaning | Fix |
|---|---|---|
| `Claude …` | Terkena batas laju / sedang menghangat | Tidak perlu apa-apa — ia mencoba ulang otomatis setiap beberapa menit |
| `Claude ⚠` | Tidak ada kredensial ditemukan | Masuk dengan Claude Code |
| `Claude !` | API mengembalikan non-200 | Buka dropdown untuk kode status / body |

## 🔒 Privasi & penafian

Plugin ini berkomunikasi **hanya** dengan `api.anthropic.com`, menggunakan token yang sudah ada di mesin Anda. Tidak ada yang dikirim ke tempat lain. Pembacaan terakhir disimpan secara lokal di `~/.cache/claude-usage-barometer.tsv`.

Ia mengandalkan endpoint penggunaan **tidak resmi** (`/api/oauth/usage`) yang dapat diubah atau dihapus Anthropic kapan saja. Jika suatu saat rusak, judul menampilkan `Claude !`. PR dipersilakan.

## 🧰 Tumpukan teknologi

| Badge | Role |
|---|---|
| ![Bash](https://img.shields.io/badge/Bash-4EAA25?logo=gnubash&logoColor=white) | Runtime plugin (~90 baris) |
| ![jq](https://img.shields.io/badge/jq-1E88E5?logo=json&logoColor=white) | Mengurai respons JSON |
| ![cURL](https://img.shields.io/badge/cURL-073551?logo=curl&logoColor=white) | Memanggil API penggunaan |
| ![SwiftBar](https://img.shields.io/badge/SwiftBar-F05138?logo=swift&logoColor=white) | Merender di bilah menu |
| ![macOS](https://img.shields.io/badge/macOS-000000?logo=apple&logoColor=white) | Host Keychain + bilah menu |
| ![Claude](https://img.shields.io/badge/Claude_API-D97757?logo=anthropic&logoColor=white) | Sumber data penggunaan |

## 📄 Lisensi

[MIT](LICENSE) © 2026 Takayuki Miyano · Atlas Associates Inc.
