# Claude Usage Barometer — Windows system-tray app (PowerShell)
# Shows 5h / 7d remaining as two stacked gauge bars in the tray icon.
# Data: GET https://api.anthropic.com/api/oauth/usage  (anthropic-beta: oauth-2025-04-20)
# Token: %USERPROFILE%\.claude\.credentials.json  (or $env:CLAUDE_CONFIG_DIR\.credentials.json)

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class IconUtil { [DllImport("user32.dll")] public static extern bool DestroyIcon(IntPtr h); }
"@

$script:Endpoint = "https://api.anthropic.com/api/oauth/usage"
$script:Beta     = "oauth-2025-04-20"
$script:Interval = 60
$script:MaxBack  = 600
$script:PrevH    = [IntPtr]::Zero
$script:U5 = $null; $script:U7 = $null; $script:R5 = $null; $script:R7 = $null; $script:ErrMsg = $null

function Get-Token {
  $dir = $env:CLAUDE_CONFIG_DIR
  if ([string]::IsNullOrEmpty($dir)) { $dir = Join-Path $env:USERPROFILE ".claude" }
  $path = Join-Path $dir ".credentials.json"
  if (-not (Test-Path $path)) { return $null }
  try {
    $j = Get-Content $path -Raw | ConvertFrom-Json
    if ($j.claudeAiOauth -and $j.claudeAiOauth.accessToken) { return $j.claudeAiOauth.accessToken }
    if ($j.accessToken) { return $j.accessToken }
  } catch {}
  return $null
}

function To-Pct($v) { if ($null -eq $v) { return -1 } else { return [int][math]::Round([double]$v) } }

function Color-For([int]$used) {
  if ($used -ge 90) { return [System.Drawing.Color]::FromArgb(255,181,82,74) }
  elseif ($used -ge 70) { return [System.Drawing.Color]::FromArgb(255,191,155,48) }
  else { return [System.Drawing.Color]::FromArgb(255,94,156,107) }
}

function Reset-Str($iso) {
  if ([string]::IsNullOrEmpty($iso)) { return "" }
  try {
    $dt = [datetimeoffset]::Parse($iso)
    $span = $dt - [datetimeoffset]::Now
    if ($span.TotalSeconds -le 0) { return "まもなく回復" }
    if ($span.TotalDays -ge 1) { return ("あと{0}日{1}時間で回復" -f [int]$span.TotalDays, $span.Hours) }
    return ("あと{0}時間{1}分で回復" -f [int]$span.TotalHours, $span.Minutes)
  } catch { return "" }
}

function Make-Icon([int]$used5,[int]$used7) {
  $bmp = New-Object System.Drawing.Bitmap 32,32
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.Clear([System.Drawing.Color]::Transparent)
  $bg = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(90,128,128,128))
  $rows = @(@(6,$used5), @(19,$used7))
  foreach ($r in $rows) {
    $y = $r[0]; $used = $r[1]
    $rem = 100 - $used; if ($used -lt 0) { $rem = 0 }
    $x = 2; $w = 28; $h = 7
    $g.FillRectangle($bg, $x, $y, $w, $h)
    $fw = [int]($w * $rem / 100)
    if ($fw -gt 0) {
      $br = New-Object System.Drawing.SolidBrush (Color-For $used)
      $g.FillRectangle($br, $x, $y, $fw, $h)
      $br.Dispose()
    }
  }
  $bg.Dispose(); $g.Dispose()
  $h = $bmp.GetHicon()
  $icon = [System.Drawing.Icon]::FromHandle($h)
  $bmp.Dispose()
  return @{ Icon = $icon; Handle = $h }
}

function Render {
  $u5 = To-Pct $script:U5; $u7 = To-Pct $script:U7
  $r5 = if ($u5 -lt 0) { -1 } else { 100 - $u5 }
  $r7 = if ($u7 -lt 0) { -1 } else { 100 - $u7 }

  $made = Make-Icon $u5 $u7
  $script:Notify.Icon = $made.Icon
  if ($script:PrevH -ne [IntPtr]::Zero) { [IconUtil]::DestroyIcon($script:PrevH) | Out-Null }
  $script:PrevH = $made.Handle

  $t5 = if ($r5 -lt 0) { "--" } else { "$r5%" }
  $t7 = if ($r7 -lt 0) { "--" } else { "$r7%" }
  if ($script:ErrMsg) { $script:Notify.Text = "Claude: $script:ErrMsg" }
  else { $script:Notify.Text = "Claude  5h $t5  /  7d $t7  (残量)" }

  $menu = New-Object System.Windows.Forms.ContextMenuStrip
  $i1 = $menu.Items.Add("5時間: $t5 残り  $(Reset-Str $script:R5)"); $i1.Enabled = $false
  $i2 = $menu.Items.Add("1週間: $t7 残り  $(Reset-Str $script:R7)"); $i2.Enabled = $false
  if ($script:ErrMsg) { $ie = $menu.Items.Add("⚠ $script:ErrMsg"); $ie.Enabled = $false }
  [void]$menu.Items.Add((New-Object System.Windows.Forms.ToolStripSeparator))
  $ir = $menu.Items.Add("今すぐ更新"); $ir.add_Click({ Update-Tray })
  $iq = $menu.Items.Add("終了"); $iq.add_Click({ $script:Notify.Visible = $false; [System.Windows.Forms.Application]::Exit() })
  $script:Notify.ContextMenuStrip = $menu
}

function Schedule {
  $script:Timer.Stop()
  $script:Timer.Interval = [int]($script:Interval * 1000)
  $script:Timer.Start()
}

function Update-Tray {
  $token = Get-Token
  if ($null -eq $token) { $script:ErrMsg = "認証情報なし (Claude Code でログイン)"; Render; Schedule; return }
  try {
    $headers = @{ Authorization = "Bearer $token"; "anthropic-beta" = $script:Beta }
    $resp = Invoke-RestMethod -Uri $script:Endpoint -Headers $headers -TimeoutSec 15
    if ($resp.five_hour) { $script:U5 = $resp.five_hour.utilization; $script:R5 = $resp.five_hour.resets_at }
    if ($resp.seven_day) { $script:U7 = $resp.seven_day.utilization; $script:R7 = $resp.seven_day.resets_at }
    $script:ErrMsg = $null; $script:Interval = 60
  } catch {
    $code = 0
    if ($_.Exception.Response) { try { $code = [int]$_.Exception.Response.StatusCode } catch {} }
    if ($code -eq 429) { $script:Interval = [math]::Min($script:Interval * 2, $script:MaxBack); $script:ErrMsg = "レート制限中" }
    else { $script:ErrMsg = "通信エラー ($code)" }
  }
  Render; Schedule
}

$script:Notify = New-Object System.Windows.Forms.NotifyIcon
$script:Notify.Icon = [System.Drawing.SystemIcons]::Application
$script:Notify.Visible = $true
$script:Timer = New-Object System.Windows.Forms.Timer
$script:Timer.Interval = 60000
$script:Timer.add_Tick({ Update-Tray })
Update-Tray
[System.Windows.Forms.Application]::Run()
