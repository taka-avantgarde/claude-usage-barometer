<div align="center">

#### 🌐 &nbsp; Language · 言語 · Idioma · اللغة · Langue · Sprache

[![English](https://img.shields.io/badge/English-555555?style=for-the-badge)](README.md)
[![日本語](https://img.shields.io/badge/%E6%97%A5%E6%9C%AC%E8%AA%9E-555555?style=for-the-badge)](README.ja.md)
[![Español](https://img.shields.io/badge/Espa%C3%B1ol-555555?style=for-the-badge)](README.es.md)
[![العربية](https://img.shields.io/badge/%D8%A7%D9%84%D8%B9%D8%B1%D8%A8%D9%8A%D8%A9-2563EB?style=for-the-badge)](README.ar.md)
[![Français](https://img.shields.io/badge/Fran%C3%A7ais-555555?style=for-the-badge)](README.fr.md)
[![Deutsch](https://img.shields.io/badge/Deutsch-555555?style=for-the-badge)](README.de.md)

</div>

<div align="center">

# 🎚️ Claude Usage Barometer

**مقياس مدمج على هيئة بطارية في شريط القوائم لحدود استخدامك في Claude.**
راقب نافذتَي **الـ5 ساعات** و**الـ7 أيام** وهما تُستنزفان في الوقت الفعلي — مباشرةً من شريط قوائم macOS.

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

## ⚡ البدء السريع

**الصق هذا السطر الواحد في الطرفية (Terminal) — هذا هو الإعداد بأكمله:**

```bash
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/install.sh | bash
```

يثبّت `jq` و SwiftBar (عبر Homebrew)، ويضع الإضافة في مكانها، ويشغّلها. عند التشغيل الأول، انقر على **Always Allow** عند ظهور نافذة سلسلة المفاتيح (Keychain). _يتطلب [Homebrew](https://brew.sh) وأن تكون مسجّلاً الدخول إلى Claude Code على هذا الـMac._

---

## 👀 معاينة

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

`█` = المتبقي، `░` = المُستهلك. يُستنزف الشريط ويحمرّ كلما اقتربت من الحد.

> 📸 ضع لقطة شاشة حقيقية في `docs/screenshot.png` وأشر إليها هنا.

## ✨ المزايا

- **مقياس على هيئة بطارية** — يُظهر `█` ما تبقّى، و`░` ما استُهلك؛ ويُستنزف كلما استهلكت حصتك.
- **مرمّز بالألوان** — يُلوَّن الشريط **green → amber → red** كلما اقتربت من الحد (دون الحاجة إلى أيقونة منفصلة).
- **مدمج** — مجرد شريطين في شريط القوائم؛ وتُظهر القائمة المنسدلة `% left` والعدّ التنازلي حتى إعادة التعيين.
- **متوافق مع حدود المعدل** — يخزّن آخر قراءة جيدة مؤقتًا ويحدّ من استدعاءات الـAPI (بفارق ≥ 3 دقائق)، فيصمد أمام حالات `429` العابرة.
- **مدرك للتحديثات** — يتحقق من GitHub مرة واحدة يوميًا ويعرض رابط "update available" في القائمة المنسدلة عند وجود إصدار أحدث.
- **معدّل تحديث قابل للضبط** — اختر **1 / 3 / 5 min** من القائمة المنسدلة (يُعرض المعدّل الحالي على هيئة `⏱ Update every N min`).
- **بلا أي بناء، Bash خالص.** سهل القراءة والتدقيق والتعديل. خاص بحكم التصميم.

## 🎨 كيف يعمل اللون

يعكس لون الشريط مدى قرب النافذة **الأكثر تقييدًا** من حدّها:

| Used | Color | Meaning |
|-----:|:-----:|:--------|
| `0–69%`  | 🟢 أخضر | متبقٍّ الكثير |
| `70–89%` | 🟡 كهرماني | يقترب من الحد |
| `90–100%`| 🔴 أحمر   | على وشك النفاد |

> يلوّن SwiftBar كل عنصر في شريط القوائم بلون واحد، لذا يستخدم شريط شريط القوائم اللونَ الأسوأ بين النافذتين. أما القائمة المنسدلة فتلوّن كل نافذة على حدة.

## 📦 المتطلبات

- **macOS** مع [SwiftBar](https://github.com/swiftbar/SwiftBar) (أو [xbar](https://github.com/matryer/xbar))
- **jq** و **curl** (يأتي curl مع macOS؛ ثبّت jq عبر `brew install jq`)
- **Claude Code** مسجّلاً الدخول على هذا الـMac — تقرأ الإضافة رمز OAuth الخاص به من سلسلة المفاتيح (Keychain)

## 🚀 التثبيت

### تثبيت سريع (سطر واحد)

```bash
curl -fsSL https://raw.githubusercontent.com/taka-avantgarde/claude-usage-barometer/main/install.sh | bash
```

يثبّت `jq` و SwiftBar عبر Homebrew، ويضع الإضافة في مكانها، ويشغّل SwiftBar. عند التشغيل الأول، انقر على **Always Allow** عند ظهور نافذة سلسلة المفاتيح (Keychain).

> يتطلب [Homebrew](https://brew.sh) وأن تكون مسجّلاً الدخول إلى **Claude Code** على هذا الـMac.

### التثبيت اليدوي

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

ثم شغّل SwiftBar ووجّه **مجلد الإضافات** الخاص به إلى `~/SwiftBar`. في المرة الأولى التي تعمل فيها الإضافة، يطلب macOS الوصول إلى *"Claude Code-credentials"* في سلسلة المفاتيح (Keychain) — انقر على **Always Allow**.

> يعني `.60s.` في اسم الملف أن شريط القوائم **يُعاد رسمه** كل 60 ثانية؛ أما الـAPI نفسه فيُستدعى فقط كل `MIN_INTERVAL` ثانية (الافتراضي 180).

## ⚙️ الإعدادات

عدّل الكتلة الموجودة في أعلى `claude-usage.60s.sh`:

| Variable | Default | What it does |
|---|---|---|
| `WARN` / `DANGER` | `70` / `90` | نسبة الاستهلاك المئوية التي تحوّل الشريط إلى الكهرماني / الأحمر |
| `OK_COLOR` / `WARN_COLOR` / `DANGER_COLOR` | sage / ochre / brick | الألوان الثلاثة |
| `FILL` / `EMPTY` | `█` / `░` | محرفا الشريط للمتبقي / المُستهلك |
| `MBAR_W` / `DROP_W` | `5` / `10` | عرض الشريط (شريط القوائم / القائمة المنسدلة) |
| refresh interval | menu | اختر **1 / 3 / 5 min** من القائمة المنسدلة `⏱` (يُخزَّن في `~/.cache/claude-usage-barometer.interval`) |
| `SCALE` | `no` | كيفية قراءة `utilization` — تُرجِع نقطة النهاية نسبًا مئوية من 0 إلى 100 (`no` = كما هي) |
| `UPDATE_CHECK` | `1` | التحقق من GitHub مرة واحدة يوميًا بحثًا عن إصدار أحدث (`0` للتعطيل) |

## 🩺 استكشاف الأخطاء وإصلاحها

| Title | Meaning | Fix |
|---|---|---|
| `Claude …` | محدود بالمعدل / قيد الإحماء | لا شيء — يعيد المحاولة تلقائيًا كل بضع دقائق |
| `Claude ⚠` | لم يُعثر على بيانات اعتماد | سجّل الدخول عبر Claude Code |
| `Claude !` | أرجع الـAPI رمزًا غير 200 | افتح القائمة المنسدلة لمعرفة رمز الحالة / المحتوى |

## 🔒 الخصوصية وإخلاء المسؤولية

تتواصل هذه الإضافة **فقط** مع `api.anthropic.com`، باستخدام الرمز الموجود مسبقًا على جهازك. لا يُرسَل أي شيء إلى أي مكان آخر. تُخزَّن آخر قراءة محليًا في `~/.cache/claude-usage-barometer.tsv`.

تعتمد على نقطة نهاية استخدام **غير رسمية** (`/api/oauth/usage`) قد تغيّرها Anthropic أو تزيلها في أي وقت. إذا توقّفت يومًا ما، يُظهر العنوان `Claude !`. طلبات الدمج (PRs) مرحّب بها.

## 🧰 الحزمة التقنية

| Badge | Role |
|---|---|
| ![Bash](https://img.shields.io/badge/Bash-4EAA25?logo=gnubash&logoColor=white) | بيئة تشغيل الإضافة (~90 سطرًا) |
| ![jq](https://img.shields.io/badge/jq-1E88E5?logo=json&logoColor=white) | تحليل استجابة JSON |
| ![cURL](https://img.shields.io/badge/cURL-073551?logo=curl&logoColor=white) | استدعاء واجهة برمجة تطبيقات الاستخدام |
| ![SwiftBar](https://img.shields.io/badge/SwiftBar-F05138?logo=swift&logoColor=white) | العرض في شريط القوائم |
| ![macOS](https://img.shields.io/badge/macOS-000000?logo=apple&logoColor=white) | سلسلة المفاتيح + مضيف شريط القوائم |
| ![Claude](https://img.shields.io/badge/Claude_API-D97757?logo=anthropic&logoColor=white) | مصدر بيانات الاستخدام |

## 📄 الترخيص

[MIT](LICENSE) © 2026 Takayuki Miyano · Atlas Associates Inc.
