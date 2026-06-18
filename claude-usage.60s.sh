#!/bin/bash
#
# Claude Usage Barometer — SwiftBar / xbar plugin
# Battery-style menu-bar gauge for Claude's 5-hour & 7-day usage limits.
# Report language is selectable from the dropdown (🌐 Language); rate-limit
# friendly; daily update check; selectable refresh interval.
#
# <xbar.title>Claude Usage Barometer</xbar.title>
# <xbar.version>v1.5.0</xbar.version>
# <xbar.author>Takayuki Miyano</xbar.author>
# <xbar.author.github>taka-avantgarde</xbar.author.github>
# <xbar.desc>Battery-style menu-bar gauge for Claude's 5-hour & 7-day usage limits.</xbar.desc>
# <xbar.dependencies>bash,jq,curl</xbar.dependencies>
# <xbar.abouturl>https://github.com/taka-avantgarde/claude-usage-barometer</xbar.abouturl>
# <swiftbar.hideAbout>false</swiftbar.hideAbout>
# <swiftbar.hideRunInTerminal>true</swiftbar.hideRunInTerminal>
# <swiftbar.hideLastUpdated>true</swiftbar.hideLastUpdated>
#
# License: MIT
#
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin"

# ─── Configuration ─────────────────────────────────────────────
VERSION="v1.5.0"
REPO="taka-avantgarde/claude-usage-barometer"
WARN=70; DANGER=90
OK_COLOR="#5E9C6B"; WARN_COLOR="#BF9B30"; DANGER_COLOR="#B5524A"
FILL="█"; EMPTY="░"; MBAR_W=5; DROP_W=10
SCALE="no"
UPDATE_CHECK=1; UPDATE_INTERVAL=86400
CACHE="$HOME/.cache/claude-usage-barometer.tsv"
UPD_CACHE="$HOME/.cache/claude-usage-barometer.update"
IF="$HOME/.cache/claude-usage-barometer.interval"   # refresh interval (1/3/5), from dropdown
LANGF="$HOME/.cache/claude-usage-barometer.lang"     # report language, from dropdown
# ───────────────────────────────────────────────────────────────

ENDPOINT="https://api.anthropic.com/api/oauth/usage"
BETA="oauth-2025-04-20"
FONT="font=Menlo size=12"

# ── Refresh interval (minutes) ──
INTERVAL_MIN=3; [ -f "$IF" ] && { read -r INTERVAL_MIN < "$IF" 2>/dev/null || INTERVAL_MIN=3; }
case "$INTERVAL_MIN" in 1|3|5) ;; *) INTERVAL_MIN=3 ;; esac
MIN_INTERVAL=$((INTERVAL_MIN*60))

# ── Report language (selectable; default = macOS language; ar/unsupported -> en) ──
L=""; [ -f "$LANGF" ] && read -r L < "$LANGF" 2>/dev/null
[ -z "$L" ] && L=$(defaults read -g AppleLocale 2>/dev/null | cut -d_ -f1 | cut -d- -f1)
case "$L" in en|ja|es|fr|de|zh|ko|pt|nl|it|vi|id|th) ;; *) L="en" ;; esac
case "$L" in
  ja) T_LEFT="残り{v}"; T_RESET="{v}後にリセット"; T_REFRESH="今すぐ更新"; T_UPDATED="更新 {v}"; T_EVERY="更新間隔 {v}分"; T_LANG="言語"; T_UPDATE="更新あり: {v}"; T_WARM="起動中"; T_NOCRED="資格情報が見つかりません"; T_RL="レート制限中" ;;
  es) T_LEFT="{v} restante"; T_RESET="se reinicia en {v}"; T_REFRESH="Actualizar ahora"; T_UPDATED="Actualizado {v}"; T_EVERY="Actualizar cada {v} min"; T_LANG="Idioma"; T_UPDATE="Actualización: {v}"; T_WARM="Iniciando"; T_NOCRED="Credenciales no encontradas"; T_RL="Límite alcanzado" ;;
  fr) T_LEFT="{v} restant"; T_RESET="réinit. dans {v}"; T_REFRESH="Actualiser"; T_UPDATED="Mis à jour {v}"; T_EVERY="Actualiser ttes les {v} min"; T_LANG="Langue"; T_UPDATE="Mise à jour : {v}"; T_WARM="Démarrage"; T_NOCRED="Identifiants introuvables"; T_RL="Limite atteinte" ;;
  de) T_LEFT="{v} übrig"; T_RESET="Reset in {v}"; T_REFRESH="Jetzt aktualisieren"; T_UPDATED="Aktualisiert {v}"; T_EVERY="Alle {v} Min aktualisieren"; T_LANG="Sprache"; T_UPDATE="Update verfügbar: {v}"; T_WARM="Startet"; T_NOCRED="Keine Anmeldedaten"; T_RL="Limit erreicht" ;;
  zh) T_LEFT="剩余{v}"; T_RESET="{v}后重置"; T_REFRESH="立即刷新"; T_UPDATED="更新于 {v}"; T_EVERY="每 {v} 分钟刷新"; T_LANG="语言"; T_UPDATE="有更新：{v}"; T_WARM="正在启动"; T_NOCRED="未找到凭据"; T_RL="已限流" ;;
  ko) T_LEFT="{v} 남음"; T_RESET="{v} 후 초기화"; T_REFRESH="지금 새로고침"; T_UPDATED="업데이트 {v}"; T_EVERY="{v}분마다 갱신"; T_LANG="언어"; T_UPDATE="업데이트 있음: {v}"; T_WARM="시작 중"; T_NOCRED="자격 증명 없음"; T_RL="요청 제한됨" ;;
  pt) T_LEFT="{v} restante"; T_RESET="redefine em {v}"; T_REFRESH="Atualizar agora"; T_UPDATED="Atualizado {v}"; T_EVERY="Atualizar a cada {v} min"; T_LANG="Idioma"; T_UPDATE="Atualização: {v}"; T_WARM="Iniciando"; T_NOCRED="Credenciais não encontradas"; T_RL="Limite atingido" ;;
  nl) T_LEFT="{v} over"; T_RESET="reset over {v}"; T_REFRESH="Nu vernieuwen"; T_UPDATED="Bijgewerkt {v}"; T_EVERY="Elke {v} min vernieuwen"; T_LANG="Taal"; T_UPDATE="Update beschikbaar: {v}"; T_WARM="Opstarten"; T_NOCRED="Geen inloggegevens"; T_RL="Limiet bereikt" ;;
  it) T_LEFT="{v} rimanente"; T_RESET="si reimposta tra {v}"; T_REFRESH="Aggiorna ora"; T_UPDATED="Aggiornato {v}"; T_EVERY="Aggiorna ogni {v} min"; T_LANG="Lingua"; T_UPDATE="Aggiornamento: {v}"; T_WARM="Avvio"; T_NOCRED="Credenziali non trovate"; T_RL="Limite raggiunto" ;;
  vi) T_LEFT="còn {v}"; T_RESET="đặt lại sau {v}"; T_REFRESH="Làm mới ngay"; T_UPDATED="Cập nhật {v}"; T_EVERY="Làm mới mỗi {v} phút"; T_LANG="Ngôn ngữ"; T_UPDATE="Có bản mới: {v}"; T_WARM="Đang khởi động"; T_NOCRED="Không tìm thấy thông tin đăng nhập"; T_RL="Bị giới hạn" ;;
  id) T_LEFT="sisa {v}"; T_RESET="reset dalam {v}"; T_REFRESH="Segarkan sekarang"; T_UPDATED="Diperbarui {v}"; T_EVERY="Segarkan tiap {v} mnt"; T_LANG="Bahasa"; T_UPDATE="Pembaruan: {v}"; T_WARM="Memulai"; T_NOCRED="Kredensial tidak ditemukan"; T_RL="Dibatasi" ;;
  th) T_LEFT="เหลือ {v}"; T_RESET="รีเซ็ตใน {v}"; T_REFRESH="รีเฟรชเดี๋ยวนี้"; T_UPDATED="อัปเดตเมื่อ {v}"; T_EVERY="รีเฟรชทุก {v} นาที"; T_LANG="ภาษา"; T_UPDATE="มีอัปเดต: {v}"; T_WARM="กำลังเริ่ม"; T_NOCRED="ไม่พบข้อมูลรับรอง"; T_RL="ถูกจำกัด" ;;
  *)  T_LEFT="{v} left"; T_RESET="resets in {v}"; T_REFRESH="Refresh now"; T_UPDATED="Updated {v}"; T_EVERY="Update every {v} min"; T_LANG="Language"; T_UPDATE="Update available: {v}"; T_WARM="Warming up"; T_NOCRED="Credentials not found"; T_RL="Rate limited — retrying soon" ;;
esac
sub() { local s="$1"; printf '%s' "${s/\{v\}/$2}"; }

col() { local p=$1; if (( p>=DANGER )); then echo "$DANGER_COLOR"
  elif (( p>=WARN )); then echo "$WARN_COLOR"; else echo "$OK_COLOR"; fi; }
ver_gt() { awk -v a="${1#v}" -v b="${2#v}" 'BEGIN{
  n=split(a,A,"."); m=split(b,B,"."); k=(n>m?n:m)
  for(i=1;i<=k;i++){x=A[i]+0; y=B[i]+0; if(y>x)exit 0; if(y<x)exit 1}
  exit 1}'; }
emit_err() { local mb="$1"; shift
  echo "${mb} | ${FONT} color=${WARN_COLOR}"; echo "---"
  local l; for l in "$@"; do echo "$l"; done
  echo "${T_REFRESH} | refresh=true"; exit 0; }

aTIME=0; sTIME=0; cU5=""; cU7=""; cR5=""; cR7=""
[ -f "$CACHE" ] && IFS=$'\t' read -r aTIME sTIME cU5 cU7 cR5 cR7 < "$CACHE"
now=$(date +%s)
write_cache() { mkdir -p "$(dirname "$CACHE")"; printf '%s\t%s\t%s\t%s\t%s\t%s\n' "$1" "$2" "$3" "$4" "$5" "$6" > "$CACHE"; }
U5="$cU5"; U7="$cU7"; R5="$cR5"; R7="$cR7"; SRC="cache"

if [ $(( now - aTIME )) -ge "$MIN_INTERVAL" ]; then
  TOKEN=$(security find-generic-password -s "Claude Code-credentials" -w 2>/dev/null \
          | jq -r '.claudeAiOauth.accessToken // .accessToken // empty' 2>/dev/null)
  [ -z "$TOKEN" ] && TOKEN=$(jq -r '.claudeAiOauth.accessToken // .accessToken // empty' \
          "$HOME/.claude/.credentials.json" 2>/dev/null)
  if [ -z "$TOKEN" ]; then
    write_cache "$now" "$sTIME" "$cU5" "$cU7" "$cR5" "$cR7"
    [ -z "$cU5$cU7" ] && emit_err "Claude ⚠" "$T_NOCRED" "Sign in with Claude Code first."
    SRC="limited"
  else
    RESP=$(curl -s -m 8 -w $'\n%{http_code}' "$ENDPOINT" \
            -H "Authorization: Bearer $TOKEN" -H "anthropic-beta: $BETA")
    CODE="${RESP##*$'\n'}"; BODY="${RESP%$'\n'*}"
    nU5=$(printf '%s' "$BODY" | jq -r '.five_hour.utilization // empty' 2>/dev/null)
    nU7=$(printf '%s' "$BODY" | jq -r '.seven_day.utilization // empty' 2>/dev/null)
    if [ "$CODE" = "200" ] && [ -n "$nU5$nU7" ]; then
      U5="$nU5"; U7="$nU7"
      R5=$(printf '%s' "$BODY" | jq -r '.five_hour.resets_at // empty' 2>/dev/null)
      R7=$(printf '%s' "$BODY" | jq -r '.seven_day.resets_at // empty' 2>/dev/null)
      SRC="live"; write_cache "$now" "$now" "$U5" "$U7" "$R5" "$R7"
    else
      write_cache "$now" "$sTIME" "$cU5" "$cU7" "$cR5" "$cR7"
      if [ -n "$cU5$cU7" ]; then SRC="limited"
      elif [ "$CODE" = "429" ]; then emit_err "Claude …" "$T_RL" "Auto-retries."
      else emit_err "Claude !" "HTTP $CODE" "$(printf '%s' "$BODY" | head -c 200 | tr '\n' ' ')"; fi
    fi
  fi
fi

LATEST=""
if [ "$UPDATE_CHECK" = "1" ]; then
  uTIME=0
  [ -f "$UPD_CACHE" ] && IFS=$'\t' read -r uTIME LATEST < "$UPD_CACHE"
  if [ $(( now - uTIME )) -ge "$UPDATE_INTERVAL" ]; then
    Lt=$(curl -s -m 5 "https://api.github.com/repos/$REPO/releases/latest" | jq -r '.tag_name // empty' 2>/dev/null)
    [ -n "$Lt" ] && LATEST="$Lt"
    mkdir -p "$(dirname "$UPD_CACHE")"; printf '%s\t%s\n' "$now" "$LATEST" > "$UPD_CACHE"
  fi
fi

to_pct() { local v="$1"; [ -z "$v" ] && { echo "-1"; return; }
  case "$SCALE" in
    yes) awk -v x="$v" 'BEGIN{printf "%.0f", x*100}' ;;
    no)  awk -v x="$v" 'BEGIN{printf "%.0f", x}' ;;
    *)   awk -v x="$v" 'BEGIN{ if (x<=1) printf "%.0f",x*100; else printf "%.0f",x }' ;;
  esac; }
bar() { local p=$1 w=$2 i f s=""; (( p<0 )) && p=0; (( p>100 )) && p=100
  f=$(( (p*w+50)/100 )); (( f>w )) && f=w
  for ((i=0;i<f;i++)); do s+="$FILL"; done
  for ((i=f;i<w;i++)); do s+="$EMPTY"; done; printf '%s' "$s"; }
fmt() { local p=$1; (( p<0 )) && { echo "--"; return; }; printf '%d%%' "$p"; }
remain() { local iso="$1" ts e n d; [ -z "$iso" ] && { echo ""; return; }
  ts="${iso/Z/+00:00}"
  ts=$(printf '%s' "$ts" | sed -E 's/\.[0-9]+//; s/([+-][0-9][0-9]):([0-9][0-9])$/\1\2/')
  e=$(date -j -f "%Y-%m-%dT%H:%M:%S%z" "$ts" +%s 2>/dev/null)
  [ -z "$e" ] && { echo "$iso"; return; }
  n=$(date +%s); d=$((e-n)); (( d<0 )) && { echo "soon"; return; }
  if (( d>=86400 )); then printf '%dd %dh' $((d/86400)) $(((d%86400)/3600))
  else printf '%dh %02dm' $((d/3600)) $(((d%3600)/60)); fi; }

[ -z "$U5$U7" ] && emit_err "Claude …" "$T_WARM" "…"
P5=$(to_pct "$U5"); P7=$(to_pct "$U7")
REM5=$(( P5<0 ? -1 : 100-P5 )); REM7=$(( P7<0 ? -1 : 100-P7 ))
WORST=$(( P5>P7 ? P5 : P7 )); (( WORST<0 )) && WORST=0

# Menu bar: colored battery bars (█ = left, ░ = used). One color = worst window.
echo "5h $(bar $REM5 $MBAR_W)  7d $(bar $REM7 $MBAR_W) | ${FONT} color=$(col $WORST)"
echo "---"
echo "5h  $(bar $REM5 $DROP_W)  $(sub "$T_LEFT" "$(fmt $REM5)") | ${FONT} color=$(col $P5)"
[ -n "$R5" ] && echo "    $(sub "$T_RESET" "$(remain "$R5")") | size=11 color=#888888"
echo "7d  $(bar $REM7 $DROP_W)  $(sub "$T_LEFT" "$(fmt $REM7)") | ${FONT} color=$(col $P7)"
[ -n "$R7" ] && echo "    $(sub "$T_RESET" "$(remain "$R7")") | size=11 color=#888888"
echo "---"
echo "⏱ $(sub "$T_EVERY" "$INTERVAL_MIN") | size=12"
echo "--1 min$([ "$INTERVAL_MIN" = 1 ] && echo "  ✓") | shell=/bin/bash param1=-c param2=\"echo 1 > $IF\" terminal=false refresh=true"
echo "--3 min$([ "$INTERVAL_MIN" = 3 ] && echo "  ✓") | shell=/bin/bash param1=-c param2=\"echo 3 > $IF\" terminal=false refresh=true"
echo "--5 min$([ "$INTERVAL_MIN" = 5 ] && echo "  ✓") | shell=/bin/bash param1=-c param2=\"echo 5 > $IF\" terminal=false refresh=true"
echo "🌐 $T_LANG | size=12"
for entry in "en:English" "ja:日本語" "es:Español" "fr:Français" "de:Deutsch" "zh:简体中文" "ko:한국어" "pt:Português" "nl:Nederlands" "it:Italiano" "vi:Tiếng Việt" "id:Bahasa Indonesia" "th:ไทย"; do
  code="${entry%%:*}"; name="${entry#*:}"; mk=""; [ "$L" = "$code" ] && mk="  ✓"
  echo "--${name}${mk} | shell=/bin/bash param1=-c param2=\"echo ${code} > $LANGF\" terminal=false refresh=true"
done
echo "---"
[ -n "$LATEST" ] && ver_gt "$VERSION" "$LATEST" && echo "⬆️ $(sub "$T_UPDATE" "$LATEST") | href=https://github.com/$REPO/releases color=#BF9B30"
case "$SRC" in
  live)    echo "$(sub "$T_UPDATED" "$(date '+%H:%M:%S')") · $VERSION | size=11 color=#888888" ;;
  limited) echo "$T_RL · $(date -r "${sTIME:-0}" '+%H:%M' 2>/dev/null) | size=11 color=#888888" ;;
  *)       echo "$(sub "$T_UPDATED" "$(date -r "${sTIME:-0}" '+%H:%M:%S' 2>/dev/null)") | size=11 color=#888888" ;;
esac
echo "${T_REFRESH} | refresh=true"
echo "Anthropic Console | href=https://console.anthropic.com/"
