<img src="https://img.shields.io/badge/Ch%E1%BB%89_macOS-007AFF?style=for-the-badge&logo=apple&logoColor=white" height="40" alt="Chỉ macOS">

<div align="center">

🇬🇧 [English](README.md) • 🇯🇵 [日本語](README.ja.md) • 🇪🇸 [Español](README.es.md) • 🇸🇦 [العربية](README.ar.md) • 🇫🇷 [Français](README.fr.md) • 🇩🇪 [Deutsch](README.de.md) • 🇨🇳 [简体中文](README.zh.md) • 🇰🇷 [한국어](README.ko.md) • 🇧🇷 [Português](README.pt.md) • 🇳🇱 [Nederlands](README.nl.md) • 🇮🇹 [Italiano](README.it.md) • 🇻🇳 **Tiếng Việt** • 🇮🇩 [Bahasa Indonesia](README.id.md) • 🇹🇭 [ไทย](README.th.md)

</div>

<div align="center">

# 🎚️ Claude Usage Barometer

**Một đồng hồ đo dạng pin nhỏ gọn trên thanh menu cho giới hạn sử dụng Claude của bạn.**
Theo dõi các khoảng **5 giờ** và **7 ngày** của bạn cạn dần theo thời gian thực — ngay trên thanh menu macOS.

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

## ⚡ Bắt đầu nhanh

**Dán một dòng này vào Terminal — đó là toàn bộ phần cài đặt:**

```bash
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/install.sh | bash
```

Nó cài đặt `jq` + SwiftBar (qua Homebrew), thả plugin vào, và khởi chạy. Trong lần chạy đầu tiên, nhấp **Always Allow** cho lời nhắc Keychain. _Yêu cầu [Homebrew](https://brew.sh) và bạn đã đăng nhập vào Claude Code trên máy Mac này._

---

## 👀 Xem trước

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

`█` = còn lại, `░` = đã dùng. Thanh cạn dần và chuyển sang đỏ khi bạn tiến gần đến giới hạn.

> 📸 Đặt một ảnh chụp màn hình thật tại `docs/screenshot.png` và tham chiếu nó ở đây.

## ✨ Tính năng

- **Đồng hồ đo dạng pin** — `█` cho thấy phần còn lại, `░` phần đã dùng; nó cạn dần khi bạn tiêu thụ hạn mức.
- **Mã hóa bằng màu sắc** — thanh được nhuộm **green → amber → red** khi bạn tiến gần đến giới hạn (không cần biểu tượng riêng).
- **Nhỏ gọn** — chỉ hai thanh trên thanh menu; danh sách thả xuống hiển thị `% left` và đồng hồ đếm ngược đặt lại.
- **Thân thiện với giới hạn tốc độ** — lưu vào bộ nhớ đệm lần đọc tốt nhất và điều tiết các lệnh gọi API (cách nhau ≥ 3 phút), vượt qua được những lần `429` ngắn.
- **Nhận biết bản cập nhật** — kiểm tra GitHub mỗi ngày một lần và hiển thị liên kết "update available" trong danh sách thả xuống khi có bản phát hành mới hơn.
- **Tần suất làm mới điều chỉnh được** — chọn **1 / 3 / 5 min** từ danh sách thả xuống (khoảng hiện tại được hiển thị là `⏱ Update every N min`).
- **Không cần build, Bash thuần.** Dễ đọc, dễ kiểm tra, và dễ tinh chỉnh. Riêng tư theo thiết kế.

## 🎨 Màu sắc hoạt động thế nào

Màu của thanh phản ánh khoảng **bị ràng buộc chặt hơn** đang gần đến giới hạn của nó như thế nào:

| Used | Color | Meaning |
|-----:|:-----:|:--------|
| `0–69%`  | 🟢 green | Còn nhiều |
| `70–89%` | 🟡 amber | Đang gần đến |
| `90–100%`| 🔴 red   | Gần hết |

> SwiftBar tô mỗi mục trên thanh menu bằng một màu duy nhất, nên thanh trên thanh menu dùng khoảng tệ hơn trong hai khoảng. Danh sách thả xuống nhuộm màu từng khoảng riêng lẻ.

## 📦 Yêu cầu

- **macOS** với [SwiftBar](https://github.com/swiftbar/SwiftBar) (hoặc [xbar](https://github.com/matryer/xbar))
- **jq** và **curl** (curl đi kèm với macOS; cài jq qua `brew install jq`)
- **Claude Code** đã đăng nhập trên máy Mac này — plugin đọc mã thông báo OAuth của nó từ Keychain của bạn

## 🚀 Cài đặt

### Cài đặt nhanh (một dòng)

```bash
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/install.sh | bash
```

Cài đặt `jq` + SwiftBar qua Homebrew, thả plugin vào, và khởi chạy SwiftBar. Trong lần chạy đầu tiên, nhấp **Always Allow** cho lời nhắc Keychain.

> Yêu cầu [Homebrew](https://brew.sh) và bạn đã đăng nhập vào **Claude Code** trên máy Mac này.

### Cài đặt thủ công

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

Sau đó khởi chạy SwiftBar và trỏ **plugin folder** của nó đến `~/SwiftBar`. Lần đầu tiên plugin chạy, macOS yêu cầu truy cập *"Claude Code-credentials"* trong Keychain của bạn — nhấp **Always Allow**.

> Phần `.60s.` trong tên tệp có nghĩa là thanh menu **vẽ lại** mỗi 60 giây; bản thân API chỉ được gọi mỗi `MIN_INTERVAL` giây (mặc định 180).

## ⚙️ Cấu hình

Chỉnh sửa khối ở đầu `claude-usage.60s.sh`:

| Variable | Default | What it does |
|---|---|---|
| `WARN` / `DANGER` | `70` / `90` | % đã dùng khiến thanh chuyển sang amber / red |
| `OK_COLOR` / `WARN_COLOR` / `DANGER_COLOR` | sage / ochre / brick | ba màu sắc |
| `FILL` / `EMPTY` | `█` / `░` | ký tự thanh còn lại / đã dùng |
| `MBAR_W` / `DROP_W` | `5` / `10` | chiều rộng thanh (thanh menu / danh sách thả xuống) |
| refresh interval | menu | chọn **1 / 3 / 5 min** từ `⏱` trong danh sách thả xuống (lưu trong `~/.cache/claude-usage-barometer.interval`) |
| `SCALE` | `no` | cách đọc `utilization` — endpoint trả về phần trăm 0–100 (`no` = giữ nguyên) |
| `UPDATE_CHECK` | `1` | kiểm tra GitHub mỗi ngày một lần để tìm bản phát hành mới hơn (`0` để tắt) |

## 🩺 Khắc phục sự cố

| Title | Meaning | Fix |
|---|---|---|
| `Claude …` | Bị giới hạn tốc độ / đang khởi động | Không cần làm gì — nó tự động thử lại sau vài phút |
| `Claude ⚠` | Không tìm thấy thông tin đăng nhập | Đăng nhập bằng Claude Code |
| `Claude !` | API trả về khác 200 | Mở danh sách thả xuống để xem mã trạng thái / nội dung |

## 🔒 Quyền riêng tư & tuyên bố miễn trừ

Plugin này **chỉ** giao tiếp với `api.anthropic.com`, sử dụng mã thông báo đã có sẵn trên máy của bạn. Không có gì được gửi đến bất kỳ nơi nào khác. Lần đọc cuối cùng được lưu cục bộ tại `~/.cache/claude-usage-barometer.tsv`.

Nó dựa vào một endpoint sử dụng **không chính thức** (`/api/oauth/usage`) mà Anthropic có thể thay đổi hoặc gỡ bỏ bất cứ lúc nào. Nếu nó từng hỏng, tiêu đề sẽ hiển thị `Claude !`. Hoan nghênh các PR.

## 🧰 Tech stack

| Badge | Role |
|---|---|
| ![Bash](https://img.shields.io/badge/Bash-4EAA25?logo=gnubash&logoColor=white) | Runtime của plugin (~90 dòng) |
| ![jq](https://img.shields.io/badge/jq-1E88E5?logo=json&logoColor=white) | Phân tích phản hồi JSON |
| ![cURL](https://img.shields.io/badge/cURL-073551?logo=curl&logoColor=white) | Gọi API sử dụng |
| ![SwiftBar](https://img.shields.io/badge/SwiftBar-F05138?logo=swift&logoColor=white) | Hiển thị trên thanh menu |
| ![macOS](https://img.shields.io/badge/macOS-000000?logo=apple&logoColor=white) | Máy chủ Keychain + thanh menu |
| ![Claude](https://img.shields.io/badge/Claude_API-D97757?logo=anthropic&logoColor=white) | Nguồn dữ liệu sử dụng |

## 📄 Giấy phép

[MIT](LICENSE) © 2026 Takayuki Miyano · Atlas Associates Inc.
