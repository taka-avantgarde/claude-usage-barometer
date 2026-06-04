# Claude Usage Barometer — Windows installer
$ErrorActionPreference = "Stop"
$repo = "taka-avantgarde/claude-usage-barometer"
$raw  = "https://raw.githubusercontent.com/$repo/main/ClaudeUsageBar.ps1"
$dst  = Join-Path $env:LOCALAPPDATA "ClaudeUsageBar"
New-Item -ItemType Directory -Force -Path $dst | Out-Null
$ps = Join-Path $dst "ClaudeUsageBar.ps1"
Write-Host "Downloading..."
Invoke-RestMethod -Uri $raw -OutFile $ps

# Auto-start at login (Startup shortcut)
$startup = [Environment]::GetFolderPath("Startup")
$lnk = Join-Path $startup "ClaudeUsageBar.lnk"
$wsh = New-Object -ComObject WScript.Shell
$sc = $wsh.CreateShortcut($lnk)
$sc.TargetPath = "powershell.exe"
$sc.Arguments = '-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "' + $ps + '"'
$sc.Save()

# Launch now (hidden)
Start-Process -WindowStyle Hidden powershell.exe -ArgumentList @("-NoProfile","-ExecutionPolicy","Bypass","-File",$ps)
Write-Host "Installed. タスクトレイにアイコンが出ます。ログイン時に自動起動します。"
