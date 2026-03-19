# github-multi-account setup script (v2 — transparent proxy)
# Installs the gh proxy function, token health monitor, and git credential helper.
#
# Usage:
#   pwsh -File setup.ps1
#   pwsh -File setup.ps1 -SkipCredentialHelper
#
# Prerequisites:
#   - gh CLI installed and authenticated for both accounts
#   - Isolated config dirs: ~/.config/gh-emu and ~/.config/gh-public
#   - Run setup-gh-isolated-auth.ps1 first if dirs don't exist

param(
    [switch]$SkipCredentialHelper,
    [switch]$SkipVerify
)

$ErrorActionPreference = 'Stop'

Write-Host "=== GitHub Multi-Account Proxy Setup ===" -ForegroundColor Cyan
Write-Host ""

# ── Step 1: Locate the proxy script ──
$proxyScript = Join-Path $PSScriptRoot "gh-proxy.ps1"
if (-not (Test-Path $proxyScript)) {
    Write-Error "gh-proxy.ps1 not found in $PSScriptRoot. Ensure it's alongside setup.ps1."
    return
}
Write-Host "[1/5] Found proxy script: $proxyScript" -ForegroundColor Green

# ── Step 2: Add proxy to PowerShell profile ──
$profilePath = $PROFILE.CurrentUserAllHosts
if (!(Test-Path $profilePath)) {
    New-Item -Path $profilePath -Force | Out-Null
    Write-Host "      Created profile: $profilePath" -ForegroundColor DarkGray
}

$profileContent = Get-Content $profilePath -Raw -ErrorAction SilentlyContinue
$marker = "# === GitHub Multi-Account Proxy ==="

if ($profileContent -match [regex]::Escape($marker)) {
    Write-Host "[2/5] Proxy already in profile — skipping" -ForegroundColor Yellow
} else {
    # Remove old-style gh auth switch aliases if present
    if ($profileContent -match "gh-personal|gh auth switch") {
        Write-Host "      Detected old gh auth switch aliases in profile" -ForegroundColor Yellow
        Write-Host "      NOTE: Old aliases will coexist. Remove manually when ready." -ForegroundColor Yellow
    }

    $block = @"

$marker
# Transparent gh proxy: auto-routes to correct GH_CONFIG_DIR based on repo remote URL.
# Also provides Test-GhTokenHealth and Repair-GhToken functions.
. "$proxyScript"
# Git credential helper respects GH_CONFIG_DIR for git push/pull:
# (configured via: git config --global credential.helper '!gh auth git-credential')
"@
    Add-Content -Path $profilePath -Value $block
    Write-Host "[2/5] Added proxy to profile: $profilePath" -ForegroundColor Green
}

# ── Step 3: Configure git credential helper ──
if (-not $SkipCredentialHelper) {
    $currentHelper = git config --global credential.helper 2>$null
    if ($currentHelper -eq '!gh auth git-credential') {
        Write-Host "[3/5] Git credential helper already configured — skipping" -ForegroundColor Yellow
    } else {
        git config --global credential.helper '!gh auth git-credential'
        Write-Host "[3/5] Configured git credential helper: gh auth git-credential" -ForegroundColor Green
    }
} else {
    Write-Host "[3/5] Skipped git credential helper (--SkipCredentialHelper)" -ForegroundColor Yellow
}

# ── Step 4: Create CMD wrappers for non-PowerShell contexts ──
$binDir = Join-Path $env:USERPROFILE ".squad\bin"
if (!(Test-Path $binDir)) { New-Item -ItemType Directory -Path $binDir -Force | Out-Null }

# CMD wrapper that sources the proxy via PowerShell
$cmdContent = @"
@echo off
REM GitHub CLI proxy — routes to correct account based on repo context
REM Uses gh-proxy.ps1 for routing logic
powershell -NoProfile -Command "& { . '$proxyScript'; gh %* }"
"@
$cmdContent | Out-File "$binDir\gh-proxy.cmd" -Encoding ascii

# Add bin to user PATH if not there
$userPath = [Environment]::GetEnvironmentVariable("PATH", "User")
if ($userPath -notmatch [regex]::Escape($binDir)) {
    [Environment]::SetEnvironmentVariable("PATH", "$binDir;$userPath", "User")
    $env:PATH = "$binDir;$env:PATH"
    Write-Host "[4/5] Added $binDir to user PATH" -ForegroundColor Green
} else {
    Write-Host "[4/5] $binDir already in PATH — skipping" -ForegroundColor Yellow
}

# ── Step 5: Verify (unless skipped) ──
if (-not $SkipVerify) {
    Write-Host "[5/5] Loading proxy and verifying..." -ForegroundColor Cyan
    . $proxyScript

    $health = Test-GhTokenHealth
    foreach ($h in $health) {
        $color = if ($h.Healthy) { 'Green' } else { 'Red' }
        $icon = if ($h.Healthy) { '✓' } else { '✗' }
        $msg = "$icon $($h.Name) ($($h.Account))"
        if ($h.Error) { $msg += " — $($h.Error)" }
        Write-Host "      $msg" -ForegroundColor $color
    }

    $allHealthy = ($health | Where-Object { -not $_.Healthy }).Count -eq 0
    if (-not $allHealthy) {
        Write-Host ""
        Write-Host "  Some profiles are unhealthy. Fix with:" -ForegroundColor Yellow
        Write-Host "    Repair-GhToken -Profile emu" -ForegroundColor Yellow
        Write-Host "    Repair-GhToken -Profile public" -ForegroundColor Yellow
    }
} else {
    Write-Host "[5/5] Skipped verification (--SkipVerify)" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Setup complete! Restart your terminal or run:" -ForegroundColor Cyan
Write-Host "  . `$PROFILE" -ForegroundColor White
Write-Host ""
Write-Host "Usage:" -ForegroundColor Cyan
Write-Host "  gh pr list              # auto-routes based on repo context" -ForegroundColor White
Write-Host "  Test-GhTokenHealth      # check all tokens" -ForegroundColor White
Write-Host "  Repair-GhToken -Profile emu  # fix expired token" -ForegroundColor White
