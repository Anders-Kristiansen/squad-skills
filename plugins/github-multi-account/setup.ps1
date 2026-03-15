# github-multi-account setup script
# Run once: pwsh -File setup.ps1 -Personal YOUR_PERSONAL -Work YOUR_WORK
param(
    [Parameter(Mandatory=$true)][string]$Personal,
    [Parameter(Mandatory=$true)][string]$Work
)

Write-Host "Setting up GitHub multi-account aliases..." -ForegroundColor Cyan

# 1. Add to PowerShell profile
$profilePath = $PROFILE.CurrentUserAllHosts
if (!(Test-Path $profilePath)) { New-Item -Path $profilePath -Force | Out-Null }
$existing = Get-Content $profilePath -Raw -ErrorAction SilentlyContinue

if ($existing -notmatch "gh-personal") {
    $block = @"

# === GitHub Multi-Account Aliases (installed by squad-skills plugin) ===
function gh-personal { gh auth switch --user $Personal 2>`$null | Out-Null; gh @args }
function gh-work { gh auth switch --user $Work 2>`$null | Out-Null; gh @args }
Set-Alias ghp gh-personal
Set-Alias ghw gh-work
# ghp = personal repos | ghw = work/EMU repos | NEVER use bare gh for repo ops
"@
    Add-Content -Path $profilePath -Value $block
    Write-Host "Added to profile: $profilePath" -ForegroundColor Green
} else {
    Write-Host "Already in profile — skipping" -ForegroundColor Yellow
}

# 2. Create CMD wrappers for non-PowerShell contexts
$binDir = Join-Path $env:USERPROFILE ".squad\bin"
if (!(Test-Path $binDir)) { New-Item -ItemType Directory -Path $binDir -Force | Out-Null }

"@echo off`ngh auth switch --user $Personal >nul 2>&1`ngh %*" | Out-File "$binDir\gh-personal.cmd" -Encoding ascii
"@echo off`ngh auth switch --user $Work >nul 2>&1`ngh %*" | Out-File "$binDir\gh-work.cmd" -Encoding ascii
"@echo off`ngh auth switch --user $Personal >nul 2>&1`ngh %*" | Out-File "$binDir\ghp.cmd" -Encoding ascii
"@echo off`ngh auth switch --user $Work >nul 2>&1`ngh %*" | Out-File "$binDir\ghw.cmd" -Encoding ascii
Write-Host "Created CMD wrappers in: $binDir" -ForegroundColor Green

# 3. Add bin to user PATH if not there
$userPath = [Environment]::GetEnvironmentVariable("PATH", "User")
if ($userPath -notmatch [regex]::Escape($binDir)) {
    [Environment]::SetEnvironmentVariable("PATH", "$binDir;$userPath", "User")
    $env:PATH = "$binDir;$env:PATH"
    Write-Host "Added $binDir to user PATH" -ForegroundColor Green
}

# 4. Load functions in current session
Invoke-Expression "function gh-personal { gh auth switch --user $Personal 2>`$null | Out-Null; gh @args }"
Invoke-Expression "function gh-work { gh auth switch --user $Work 2>`$null | Out-Null; gh @args }"
Set-Alias ghp gh-personal
Set-Alias ghw gh-work

# 5. Install SKILL.md to .squad if it exists
$squadSkillDir = Join-Path (git rev-parse --show-toplevel 2>$null) ".squad\skills\github-multi-account"
if ($squadSkillDir -and (Test-Path (Split-Path $squadSkillDir))) {
    if (!(Test-Path $squadSkillDir)) { New-Item -ItemType Directory -Path $squadSkillDir -Force | Out-Null }
    $skillUrl = "https://raw.githubusercontent.com/tamirdresher/squad-skills/main/plugins/github-multi-account/SKILL.md"
    try {
        Invoke-WebRequest -Uri $skillUrl -OutFile "$squadSkillDir\SKILL.md" -UseBasicParsing
        Write-Host "Installed SKILL.md to: $squadSkillDir" -ForegroundColor Green
    } catch { Write-Host "Could not download SKILL.md (install manually)" -ForegroundColor Yellow }
}

Write-Host ""
Write-Host "Done! Test it:" -ForegroundColor Cyan
Write-Host "  ghp api user --jq '.login'   # should show: $Personal"
Write-Host "  ghw api user --jq '.login'   # should show: $Work"
