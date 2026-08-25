# hook-play.ps1
# Codex Stop hook script
# Plays the creeper boom sound in background without blocking
# Usage: powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "hook-play.ps1"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
if (-not $scriptDir -and $env:PLUGIN_ROOT) {
    $scriptDir = $env:PLUGIN_ROOT
}
$soundPath = Join-Path $scriptDir "assets\creeper_booms.mp3"

if (-not (Test-Path $soundPath)) {
    exit 1
}

try {
    Add-Type -AssemblyName PresentationCore -ErrorAction Stop
    $player = New-Object System.Windows.Media.MediaPlayer
    $player.Open($soundPath)
    $player.Play()
    Start-Sleep -Seconds 5
    $player.Close()
} catch {
    # Silent fail - don't interrupt the user
    exit 1
}
