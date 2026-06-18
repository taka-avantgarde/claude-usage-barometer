<img src="https://img.shields.io/badge/%E0%B9%80%E0%B8%89%E0%B8%9E%E0%B8%B2%E0%B8%B0_macOS-007AFF?style=for-the-badge&logo=apple&logoColor=white" height="40" alt="เฉพาะ macOS">

<div align="center">

🇬🇧 [English](README.md) • 🇯🇵 [日本語](README.ja.md) • 🇪🇸 [Español](README.es.md) • 🇸🇦 [العربية](README.ar.md) • 🇫🇷 [Français](README.fr.md) • 🇩🇪 [Deutsch](README.de.md) • 🇨🇳 [简体中文](README.zh.md) • 🇰🇷 [한국어](README.ko.md) • 🇧🇷 [Português](README.pt.md) • 🇳🇱 [Nederlands](README.nl.md) • 🇮🇹 [Italiano](README.it.md) • 🇻🇳 [Tiếng Việt](README.vi.md) • 🇮🇩 [Bahasa Indonesia](README.id.md) • 🇹🇭 **ไทย**

</div>

<div align="center">

# 🎚️ Claude Usage Barometer

**เกจวัดสไตล์แบตเตอรี่ขนาดกะทัดรัดบนแถบเมนู สำหรับขีดจำกัดการใช้งาน Claude ของคุณ**
เฝ้าดูช่วงเวลา **5 ชั่วโมง** และ **7 วัน** ของคุณลดลงแบบเรียลไทม์ — ตรงจากแถบเมนูของ macOS

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

## ⚡ เริ่มต้นอย่างรวดเร็ว

**วางคำสั่งบรรทัดเดียวนี้ลงใน Terminal — นี่คือการตั้งค่าทั้งหมด:**

```bash
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/install.sh | bash
```

มันจะติดตั้ง `jq` + SwiftBar (ผ่าน Homebrew) ใส่ปลั๊กอินเข้าไป และเปิดใช้งาน เมื่อรันครั้งแรก ให้คลิก **Always Allow** สำหรับข้อความแจ้งเตือนของ Keychain _ต้องมี [Homebrew](https://brew.sh) และคุณต้องลงชื่อเข้าใช้ Claude Code บน Mac เครื่องนี้_

---

## 👀 ตัวอย่าง

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

`█` = ส่วนที่เหลือ, `░` = ส่วนที่ใช้ไปแล้ว แถบจะลดลงและเปลี่ยนเป็นสีแดงเมื่อคุณเข้าใกล้ขีดจำกัด

> 📸 วางภาพหน้าจอจริงที่ `docs/screenshot.png` แล้วอ้างอิงถึงตรงนี้

## ✨ คุณสมบัติ

- **เกจวัดสไตล์แบตเตอรี่** — `█` แสดงสิ่งที่เหลืออยู่, `░` แสดงสิ่งที่ใช้ไปแล้ว มันจะลดลงเมื่อคุณใช้โควต้าของคุณ
- **เข้ารหัสด้วยสี** — แถบจะถูกแต่งแต้มเป็น **เขียว → เหลืองอำพัน → แดง** เมื่อคุณเข้าใกล้ขีดจำกัด (ไม่ต้องมีไอคอนแยกต่างหาก)
- **กะทัดรัด** — มีเพียงสองแถบบนแถบเมนู ส่วนดร็อปดาวน์แสดง `% left` และนับถอยหลังการรีเซ็ต
- **เป็นมิตรกับ rate-limit** — แคชค่าอ่านที่ดีล่าสุดและจำกัดการเรียก API (ห่างกัน ≥ 3 นาที) เพื่อรอดผ่านช่วง `429` สั้น ๆ
- **รับรู้การอัปเดต** — ตรวจสอบ GitHub วันละครั้งและแสดงลิงก์ "update available" ในดร็อปดาวน์เมื่อมีรีลีสใหม่กว่า
- **ปรับการรีเฟรชได้** — เลือก **1 / 3 / 5 นาที** จากดร็อปดาวน์ (ช่วงเวลาปัจจุบันแสดงเป็น `⏱ Update every N min`)
- **ไม่มีการ build, เป็น Bash ล้วน ๆ** อ่าน ตรวจสอบ และปรับแต่งได้ง่าย ออกแบบมาให้เป็นส่วนตัว

## 🎨 การทำงานของสี

สีของแถบสะท้อนว่าช่วงเวลาที่ **ถูกจำกัดมากกว่า** อยู่ใกล้ขีดจำกัดของมันแค่ไหน:

| Used | Color | Meaning |
|-----:|:-----:|:--------|
| `0–69%`  | 🟢 เขียว | เหลือเยอะ |
| `70–89%` | 🟡 เหลืองอำพัน | เริ่มใกล้แล้ว |
| `90–100%`| 🔴 แดง   | เกือบหมดแล้ว |

> SwiftBar ระบายสีรายการบนแถบเมนูแต่ละรายการด้วยสีเดียว ดังนั้นแถบบนแถบเมนูจึงใช้ค่าที่แย่กว่าจากสองช่วงเวลา ส่วนดร็อปดาวน์จะแต่งแต้มสีให้แต่ละช่วงเวลาแยกกัน

## 📦 ความต้องการของระบบ

- **macOS** พร้อม [SwiftBar](https://github.com/swiftbar/SwiftBar) (หรือ [xbar](https://github.com/matryer/xbar))
- **jq** และ **curl** (curl มาพร้อมกับ macOS; ติดตั้ง jq ผ่าน `brew install jq`)
- **Claude Code** ที่ลงชื่อเข้าใช้บน Mac เครื่องนี้ — ปลั๊กอินจะอ่าน OAuth token ของมันจาก Keychain ของคุณ

## 🚀 การติดตั้ง

### ติดตั้งแบบรวดเร็ว (บรรทัดเดียว)

```bash
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/install.sh | bash
```

ติดตั้ง `jq` + SwiftBar ผ่าน Homebrew ใส่ปลั๊กอินเข้าไป และเปิดใช้งาน SwiftBar เมื่อรันครั้งแรก ให้คลิก **Always Allow** สำหรับข้อความแจ้งเตือนของ Keychain

> ต้องมี [Homebrew](https://brew.sh) และคุณต้องลงชื่อเข้าใช้ **Claude Code** บน Mac เครื่องนี้

### ติดตั้งด้วยตนเอง

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

จากนั้นเปิด SwiftBar แล้วชี้ **plugin folder** ของมันไปที่ `~/SwiftBar` เมื่อปลั๊กอินรันเป็นครั้งแรก macOS จะขอสิทธิ์เข้าถึง *"Claude Code-credentials"* ใน Keychain ของคุณ — ให้คลิก **Always Allow**

> `.60s.` ในชื่อไฟล์หมายความว่าแถบเมนูจะ **วาดใหม่** ทุก 60 วินาที ส่วน API เองจะถูกเรียกทุก `MIN_INTERVAL` วินาทีเท่านั้น (ค่าเริ่มต้น 180)

## ⚙️ การกำหนดค่า

แก้ไขบล็อกที่ด้านบนของ `claude-usage.60s.sh`:

| Variable | Default | What it does |
|---|---|---|
| `WARN` / `DANGER` | `70` / `90` | % ที่ใช้ไปซึ่งทำให้แถบเปลี่ยนเป็นสีเหลืองอำพัน / แดง |
| `OK_COLOR` / `WARN_COLOR` / `DANGER_COLOR` | sage / ochre / brick | สามสี |
| `FILL` / `EMPTY` | `█` / `░` | อักขระแถบส่วนที่เหลือ / ที่ใช้ไปแล้ว |
| `MBAR_W` / `DROP_W` | `5` / `10` | ความกว้างของแถบ (แถบเมนู / ดร็อปดาวน์) |
| refresh interval | menu | เลือก **1 / 3 / 5 นาที** จากดร็อปดาวน์ `⏱` (เก็บไว้ใน `~/.cache/claude-usage-barometer.interval`) |
| `SCALE` | `no` | วิธีอ่าน `utilization` — เอนด์พอยต์คืนค่าเปอร์เซ็นต์ 0–100 (`no` = ตามเดิม) |
| `UPDATE_CHECK` | `1` | ตรวจสอบ GitHub วันละครั้งเพื่อหารีลีสใหม่กว่า (`0` เพื่อปิดใช้งาน) |

## 🩺 การแก้ไขปัญหา

| Title | Meaning | Fix |
|---|---|---|
| `Claude …` | ถูกจำกัดอัตรา / กำลังอุ่นเครื่อง | ไม่ต้องทำอะไร — มันจะลองใหม่อัตโนมัติทุกไม่กี่นาที |
| `Claude ⚠` | ไม่พบ credentials | ลงชื่อเข้าใช้ด้วย Claude Code |
| `Claude !` | API คืนค่าที่ไม่ใช่ 200 | เปิดดร็อปดาวน์เพื่อดูรหัสสถานะ / เนื้อหา |

## 🔒 ความเป็นส่วนตัวและข้อจำกัดความรับผิดชอบ

ปลั๊กอินนี้สื่อสารกับ `api.anthropic.com` **เท่านั้น** โดยใช้ token ที่อยู่บนเครื่องของคุณอยู่แล้ว ไม่มีการส่งสิ่งใดไปที่อื่น ค่าอ่านล่าสุดจะถูกแคชไว้ในเครื่องที่ `~/.cache/claude-usage-barometer.tsv`

มันอาศัยเอนด์พอยต์การใช้งานที่ **ไม่เป็นทางการ** (`/api/oauth/usage`) ซึ่ง Anthropic อาจเปลี่ยนแปลงหรือลบออกเมื่อใดก็ได้ หากมันเสียขึ้นมา ชื่อเรื่องจะแสดง `Claude !` ยินดีรับ PR

## 🧰 Tech stack

| Badge | Role |
|---|---|
| ![Bash](https://img.shields.io/badge/Bash-4EAA25?logo=gnubash&logoColor=white) | รันไทม์ของปลั๊กอิน (~90 บรรทัด) |
| ![jq](https://img.shields.io/badge/jq-1E88E5?logo=json&logoColor=white) | แยกวิเคราะห์การตอบกลับ JSON |
| ![cURL](https://img.shields.io/badge/cURL-073551?logo=curl&logoColor=white) | เรียก usage API |
| ![SwiftBar](https://img.shields.io/badge/SwiftBar-F05138?logo=swift&logoColor=white) | แสดงผลบนแถบเมนู |
| ![macOS](https://img.shields.io/badge/macOS-000000?logo=apple&logoColor=white) | Keychain + โฮสต์แถบเมนู |
| ![Claude](https://img.shields.io/badge/Claude_API-D97757?logo=anthropic&logoColor=white) | แหล่งข้อมูลการใช้งาน |

## 📄 ลิขสิทธิ์

[MIT](LICENSE) © 2026 Takayuki Miyano · Atlas Associates Inc.
