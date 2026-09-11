<#
.SYNOPSIS
    Sets up symbolic links for AI agent configurations on Windows.
.DESCRIPTION
    Creates symlinks from the user's home directory to this repository
    for GitHub Copilot instructions, Antigravity/Gemini configuration, and AWS Kiro steering.
.PARAMETER Profile
    The configuration profile to apply ('personal', 'enterprise', 'work', 'acme'). Defaults to 'personal'.
.PARAMETER Force
    Overwrites existing target symlinks/hardlinks.
.EXAMPLE
    .\scripts\setup.ps1 -Profile personal
.EXAMPLE
    .\scripts\setup.ps1 -Profile enterprise -Force
#>

[CmdletBinding()]
param(
    [ValidateSet("personal", "enterprise", "work", "acme")]
    [string]$Profile = "personal",

    [switch]$Force
)

$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)

if ($Profile -in @("enterprise", "work", "acme")) {
    $CopilotSource = Join-Path $RepoRoot "enterprise\copilot\.copilot\instructions"
    $GeminiSource = Join-Path $RepoRoot "enterprise\gemini\.gemini\GEMINI.md"
    $KiroSource = Join-Path $RepoRoot "enterprise\kiro\.kiro\steering"
} else {
    $CopilotSource = Join-Path $RepoRoot "copilot\.copilot\instructions"
    $GeminiSource = Join-Path $RepoRoot "gemini\.gemini\GEMINI.md"
    $KiroSource = $null
}

$CopilotTargetDir = Join-Path $HOME ".copilot"
$CopilotTarget = Join-Path $CopilotTargetDir "instructions"

$GeminiTargetDir = Join-Path $HOME ".gemini"
$GeminiTarget = Join-Path $GeminiTargetDir "GEMINI.md"

$KiroTargetDir = Join-Path $HOME ".kiro"
$KiroTarget = Join-Path $KiroTargetDir "steering"

Write-Host "Setting up AI Agent configurations for Windows [Profile: $Profile]..." -ForegroundColor Cyan

# 1. Setup GitHub Copilot (Directory Symlink / Junction)
if (-not (Test-Path $CopilotTargetDir)) {
    New-Item -ItemType Directory -Path $CopilotTargetDir -Force | Out-Null
}

if (Test-Path $CopilotTarget) {
    if ($Force) {
        Write-Host "Removing existing Copilot target: $CopilotTarget" -ForegroundColor Yellow
        Remove-Item -Path $CopilotTarget -Recurse -Force
    } else {
        Write-Host "Copilot instructions symlink already exists at: $CopilotTarget" -ForegroundColor Yellow
        Write-Host "Use -Force to overwrite." -ForegroundColor Yellow
    }
}

if (-not (Test-Path $CopilotTarget)) {
    try {
        New-Item -ItemType SymbolicLink -Path $CopilotTarget -Target $CopilotSource | Out-Null
        Write-Host "Linked Copilot instructions (SymbolicLink): $CopilotTarget -> $CopilotSource" -ForegroundColor Green
    } catch {
        Write-Host "SymbolicLink failed, attempting Directory Junction..." -ForegroundColor Yellow
        New-Item -ItemType Junction -Path $CopilotTarget -Target $CopilotSource | Out-Null
        Write-Host "Linked Copilot instructions (Junction): $CopilotTarget -> $CopilotSource" -ForegroundColor Green
    }
}

# 2. Setup Antigravity / Gemini CLI (File Symlink / HardLink Fallback)
if (-not (Test-Path $GeminiTargetDir)) {
    New-Item -ItemType Directory -Path $GeminiTargetDir -Force | Out-Null
}

if (Test-Path $GeminiTarget) {
    if ($Force) {
        Write-Host "Removing existing Gemini target: $GeminiTarget" -ForegroundColor Yellow
        Remove-Item -Path $GeminiTarget -Force
    } else {
        Write-Host "Gemini configuration target already exists at: $GeminiTarget" -ForegroundColor Yellow
        Write-Host "Use -Force to overwrite." -ForegroundColor Yellow
    }
}

if (-not (Test-Path $GeminiTarget)) {
    try {
        New-Item -ItemType SymbolicLink -Path $GeminiTarget -Target $GeminiSource | Out-Null
        Write-Host "Linked Gemini configuration (SymbolicLink): $GeminiTarget -> $GeminiSource" -ForegroundColor Green
    } catch {
        try {
            Write-Host "SymbolicLink failed (no Admin/DevMode). Attempting HardLink..." -ForegroundColor Yellow
            New-Item -ItemType HardLink -Path $GeminiTarget -Target $GeminiSource | Out-Null
            Write-Host "Linked Gemini configuration (HardLink): $GeminiTarget -> $GeminiSource" -ForegroundColor Green
        } catch {
            Write-Warning "Could not create HardLink. Try enabling Windows Developer Mode or running PowerShell as Administrator."
        }
    }
}

# 3. Setup AWS Kiro (Directory Symlink / Junction - if enterprise profile)
if ($KiroSource) {
    if (-not (Test-Path $KiroTargetDir)) {
        New-Item -ItemType Directory -Path $KiroTargetDir -Force | Out-Null
    }

    if (Test-Path $KiroTarget) {
        if ($Force) {
            Write-Host "Removing existing Kiro target: $KiroTarget" -ForegroundColor Yellow
            Remove-Item -Path $KiroTarget -Recurse -Force
        } else {
            Write-Host "Kiro steering symlink already exists at: $KiroTarget" -ForegroundColor Yellow
            Write-Host "Use -Force to overwrite." -ForegroundColor Yellow
        }
    }

    if (-not (Test-Path $KiroTarget)) {
        try {
            New-Item -ItemType SymbolicLink -Path $KiroTarget -Target $KiroSource | Out-Null
            Write-Host "Linked Kiro steering (SymbolicLink): $KiroTarget -> $KiroSource" -ForegroundColor Green
        } catch {
            Write-Host "SymbolicLink failed, attempting Directory Junction..." -ForegroundColor Yellow
            New-Item -ItemType Junction -Path $KiroTarget -Target $KiroSource | Out-Null
            Write-Host "Linked Kiro steering (Junction): $KiroTarget -> $KiroSource" -ForegroundColor Green
        }
    }
}

Write-Host "Setup complete for profile '$Profile'!" -ForegroundColor Cyan
