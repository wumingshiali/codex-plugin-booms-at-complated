# test-sound.ps1
# Test audio playback functionality
# Usage: .\test-sound.ps1

Write-Host "====================================" -ForegroundColor Cyan
Write-Host "   Creeper Booms Sound Test Tool   " -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$soundPath = Join-Path $scriptDir "assets\creeper_booms.mp3"

# 1. Check if file exists
Write-Host "[1/3] Checking audio file..." -ForegroundColor Yellow
if (Test-Path $soundPath) {
    $fileInfo = Get-Item $soundPath
    $sizeKB = [math]::Round($fileInfo.Length / 1KB, 2)
    Write-Host "  [OK] Audio file exists" -ForegroundColor Green
    Write-Host "  Path: $soundPath" -ForegroundColor Gray
    Write-Host "  Size: ${sizeKB} KB" -ForegroundColor Gray
} else {
    Write-Host "  [FAIL] Audio file not found!" -ForegroundColor Red
    Write-Host "  Expected: $soundPath" -ForegroundColor Red
    exit 1
}

# 2. Check PresentationCore assembly
Write-Host "[2/3] Checking playback component..." -ForegroundColor Yellow
try {
    Add-Type -AssemblyName PresentationCore -ErrorAction Stop
    Write-Host "  [OK] PresentationCore available" -ForegroundColor Green
} catch {
    Write-Host "  [FAIL] PresentationCore not available: $_" -ForegroundColor Red
    exit 1
}

# 3. Playback test
Write-Host "[3/3] Playback test..." -ForegroundColor Yellow
Write-Host "  Now playing creeper boom sound (3 seconds)..." -ForegroundColor Magenta
Write-Host ""

try {
    $player = New-Object System.Windows.Media.MediaPlayer
    $player.Open($soundPath)
    $player.Play()
    Start-Sleep -Seconds 3
    $player.Close()
    Write-Host ""
    Write-Host "  [OK] Playback test passed!" -ForegroundColor Green
} catch {
    Write-Host "  [FAIL] Playback failed: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "====================================" -ForegroundColor Green
Write-Host "   [OK] All tests passed!          " -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green
