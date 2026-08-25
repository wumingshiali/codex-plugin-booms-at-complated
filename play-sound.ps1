# play-sound.ps1
# Play creeper boom sound effect
# Usage: .\play-sound.ps1 [-Duration 5]

param(
    [int]$Duration = 5
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$soundPath = Join-Path $scriptDir "assets\creeper_booms.mp3"

if (-not (Test-Path $soundPath)) {
    Write-Host "[FAIL] Audio file not found: $soundPath" -ForegroundColor Red
    exit 1
}

Write-Host "[PLAY] Playing creeper boom sound..." -ForegroundColor Green
Write-Host "  File: $soundPath" -ForegroundColor Gray

try {
    Add-Type -AssemblyName PresentationCore -ErrorAction Stop
    $player = New-Object System.Windows.Media.MediaPlayer
    $player.Open($soundPath)
    $player.Play()
    Write-Host "  Playing... (${Duration}s)" -ForegroundColor Cyan
    Start-Sleep -Seconds $Duration
    $player.Close()
    Write-Host "[OK] Playback finished!" -ForegroundColor Green
} catch {
    Write-Host "[FAIL] Playback failed: $_" -ForegroundColor Red
    exit 1
}
