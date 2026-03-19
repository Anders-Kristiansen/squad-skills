# gh-proxy.ps1 — Transparent gh proxy with auto-routing and token health
# Dot-source from $PROFILE:  . "path\to\gh-proxy.ps1"
#
# Based on Picard's Decision: GH Auth Proxy — Transparent Multi-Identity Routing
# The existing GH_CONFIG_DIR isolation is 90% there — this proxy makes it transparent.

#region ── Routing Configuration ──

# Routing table: regex pattern on git remote URL → GH_CONFIG_DIR
$script:GH_ROUTING_TABLE = @(
    @{ Pattern = 'tamirdresher_microsoft'; ConfigDir = "$HOME\.config\gh-emu";    Label = 'EMU' }
    @{ Pattern = 'tamirdresher/';          ConfigDir = "$HOME\.config\gh-public"; Label = 'Personal' }
)
$script:GH_DEFAULT_CONFIG = "$HOME\.config\gh-emu"  # Default to EMU (work context)

#endregion

#region ── Resolve Real gh.exe ──

$script:GH_REAL_PATH = (Get-Command gh.exe -ErrorAction SilentlyContinue)?.Source
if (-not $script:GH_REAL_PATH) {
    $script:GH_REAL_PATH = (Get-Command gh -CommandType Application -ErrorAction SilentlyContinue)?.Source
}
if (-not $script:GH_REAL_PATH) {
    Write-Warning "gh-proxy: Could not find gh.exe on PATH. Proxy will not function."
}

#endregion

#region ── Transparent gh Function ──

function gh {
    <#
    .SYNOPSIS
        Transparent proxy for gh CLI — auto-routes to correct GH_CONFIG_DIR based on git remote URL.
    .DESCRIPTION
        Intercepts gh calls, detects the repo's GitHub identity from the origin remote,
        sets GH_CONFIG_DIR to the matching isolated config directory, and delegates to gh.exe.
        If GH_CONFIG_DIR is already set (by Ralph, ghe, ghp, etc.), the proxy respects it.
    #>
    [CmdletBinding()]
    param([Parameter(ValueFromRemainingArguments)] $Arguments)

    if (-not $script:GH_REAL_PATH) {
        Write-Error "gh-proxy: gh.exe not found. Install GitHub CLI first."
        return
    }

    # If GH_CONFIG_DIR is explicitly set by caller (ghe/ghp/Ralph), respect it
    if (-not $env:GH_CONFIG_DIR) {
        $configDir = $script:GH_DEFAULT_CONFIG
        try {
            $remote = & git remote get-url origin 2>$null
            if ($remote) {
                foreach ($route in $script:GH_ROUTING_TABLE) {
                    if ($remote -match $route.Pattern) {
                        $configDir = $route.ConfigDir
                        break
                    }
                }
            }
        } catch { }
        $env:GH_CONFIG_DIR = $configDir
    }

    & $script:GH_REAL_PATH @Arguments
}

#endregion

#region ── Token Health Monitor ──

function Test-GhTokenHealth {
    <#
    .SYNOPSIS
        Check if GitHub tokens are valid for one or both profiles.
    .PARAMETER Profile
        Which profile to check: 'emu', 'public', or 'all' (default).
    .EXAMPLE
        Test-GhTokenHealth
        Test-GhTokenHealth -Profile emu
    #>
    [CmdletBinding()]
    param(
        [ValidateSet('emu', 'public', 'all')]
        [string]$Profile = 'all'
    )

    $profiles = @{
        emu    = @{ Dir = "$HOME\.config\gh-emu";    Account = 'tamirdresher_microsoft' }
        public = @{ Dir = "$HOME\.config\gh-public"; Account = 'tamirdresher' }
    }

    $toCheck = if ($Profile -eq 'all') { $profiles.Keys } else { @($Profile) }
    $results = @()

    $savedConfigDir = $env:GH_CONFIG_DIR

    foreach ($name in $toCheck) {
        $p = $profiles[$name]
        $env:GH_CONFIG_DIR = $p.Dir

        $status = @{ Name = $name; Account = $p.Account; Healthy = $false; Error = $null }

        try {
            $user = & $script:GH_REAL_PATH api user --jq '.login' 2>&1
            if ($LASTEXITCODE -eq 0 -and $user -eq $p.Account) {
                $status.Healthy = $true
            } else {
                $status.Error = "Expected $($p.Account), got: $user"
            }
        } catch {
            $status.Error = $_.Exception.Message
        }
        $results += [PSCustomObject]$status
    }

    # Restore prior GH_CONFIG_DIR
    if ($savedConfigDir) {
        $env:GH_CONFIG_DIR = $savedConfigDir
    } else {
        Remove-Item Env:\GH_CONFIG_DIR -ErrorAction SilentlyContinue
    }

    return $results
}

function Repair-GhToken {
    <#
    .SYNOPSIS
        Re-authenticate an expired GitHub profile via browser OAuth flow.
    .PARAMETER Profile
        Which profile to repair: 'emu' or 'public'.
    .EXAMPLE
        Repair-GhToken -Profile emu
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateSet('emu', 'public')]
        [string]$Profile
    )

    $dirs = @{ emu = "$HOME\.config\gh-emu"; public = "$HOME\.config\gh-public" }
    $env:GH_CONFIG_DIR = $dirs[$Profile]

    Write-Host "Repairing $Profile profile..." -ForegroundColor Yellow
    Write-Host "This will open a browser for authentication." -ForegroundColor Yellow
    & $script:GH_REAL_PATH auth login --hostname github.com --git-protocol https --web
}

#endregion

Write-Host "gh-proxy loaded: transparent multi-account routing active" -ForegroundColor DarkGray
