param(
  [Parameter(ValueFromRemainingArguments = $true)]
  [string[]]$Args
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Quote-Bash([string]$Value) {
  if ($null -eq $Value) { return "''" }
  return "'" + ($Value -replace "'", "'\''") + "'"
}

$ScriptPath = $MyInvocation.MyCommand.Path
$ScriptDir = Split-Path -Parent $ScriptPath
$RepoRoot = Split-Path -Parent $ScriptDir

if (-not (Get-Command wsl.exe -ErrorAction SilentlyContinue)) {
  throw "codex-project.ps1 requires WSL. Install WSL, then rerun this launcher from Windows."
}

$WslRepoRoot = (& wsl.exe wslpath -a $RepoRoot).Trim()
$CodexScript = Quote-Bash("$WslRepoRoot/bin/codex-project")
$CdTarget = Quote-Bash($WslRepoRoot)
$ArgList = ($Args | ForEach-Object { Quote-Bash $_ }) -join ' '

$Command = "cd $CdTarget && exec $CodexScript $ArgList"
& wsl.exe bash -lc $Command
exit $LASTEXITCODE
