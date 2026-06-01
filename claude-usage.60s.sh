#!/bin/bash
#
# Claude Usage Barometer — SwiftBar / xbar plugin
# A compact, battery-style menu-bar gauge for Claude's 5-hour and 7-day
# usage limits. The bar shows what's LEFT (█) vs used up (░) and is tinted
# green -> amber -> red as you approach the limit. Rate-limit friendly.
#
# <xbar.title>Claude Usage Barometer</xbar.title>
# <xbar.version>v1.2.0</xbar.version>
# <xbar.author>Takayuki Miyano</xbar.author>
# <xbar.author.github>taka-avantgarde</xbar.author.github>
# <xbar.desc>Compact battery-style menu-bar gauge for Claude's 5-hour & 7-day usage limits.</xbar.desc>
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
WARN=70                 # % used -> amber
DANGER=90               # % used -> red
OK_COLOR="#5E9C6B"; WARN_COLOR="#BF9B30"; DANGER_COLOR="#B5524A"
FILL="█"; EMPTY="░"     # FILL = remaining, EMPTY = used up
MBAR_W=5                # bar width in the menu bar
DROP_W=10               # bar width in the dropdown
SCALE="auto"            # auto | yes | no  (multiply utilization by 100?)
MIN_INTERVAL=180        # min seconds between real API calls (rate-limit guard)
# ───────────────────────────────────────────────────────────────

ENDPOINT="https://api.anthropic.com/api/oauth/usage"
BETA="oauth-2025-04-20"
CACHE="$HOME/.cache/claude-usage-barometer.tsv"
FONT="font=Menlo size=12"

col() { local p=$1; if (( p>=DANGER )); then echo "$DANGER_COLOR"
  elif (( p>=WARN )); then echo "$WARN_COLOR"; else echo "$OK_COLOR"; fi; }
emit_err() { local mb="$1"; shift
  echo "${mb} | ${FONT} color=${WARN_COLOR}"; echo "---"
  local l; for l in "$@"; do echo "$l"; done
  echo "Refresh now | refresh=true"; exit 0; }

# ── Cache:  attemptTime \t successTime \t U5 \t U7 \t R5 \t R7 ──
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
    [ -z "$cU5$cU7" ] && emit_err "Claude ⚠" "Credentials not found" "Sign in with Claude Code first."
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
      elif [ "$CODE" = "429" ]; then emit_err "Claude …" "Rate limited — retrying soon" "Auto-retries every few minutes."
      else emit_err "Claude !" "HTTP $CODE" "$(printf '%s' "$BODY" | head -c 200 | tr '\n' ' ')"; fi
    fi
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

[ -z "$U5$U7" ] && emit_err "Claude …" "Warming up" "Fetching first reading… (auto-retries)"
P5=$(to_pct "$U5"); P7=$(to_pct "$U7")
REM5=$(( P5<0 ? -1 : 100-P5 )); REM7=$(( P7<0 ? -1 : 100-P7 ))
WORST=$(( P5>P7 ? P5 : P7 )); (( WORST<0 )) && WORST=0

# Menu bar: colored battery bars (█ = left, ░ = used). One color = worst window.
echo "5h $(bar $REM5 $MBAR_W)  7d $(bar $REM7 $MBAR_W) | ${FONT} color=$(col $WORST)"
echo "---"
echo "5-hour   $(bar $REM5 $DROP_W)  $(fmt $REM5) left | ${FONT} color=$(col $P5)"
[ -n "$R5" ] && echo "         resets in $(remain "$R5") | size=11 color=#888888"
echo "7-day    $(bar $REM7 $DROP_W)  $(fmt $REM7) left | ${FONT} color=$(col $P7)"
[ -n "$R7" ] && echo "         resets in $(remain "$R7") | size=11 color=#888888"
echo "---"
case "$SRC" in
  live)    echo "Updated $(date '+%H:%M:%S') | size=11 color=#888888" ;;
  limited) echo "Rate-limited · last good $(date -r "${sTIME:-0}" '+%H:%M' 2>/dev/null) | size=11 color=#888888" ;;
  *)       echo "Updated $(date -r "${sTIME:-0}" '+%H:%M:%S' 2>/dev/null) · cached | size=11 color=#888888" ;;
esac
echo "Refresh now | refresh=true"
echo "Anthropic Console | href=https://console.anthropic.com/"
