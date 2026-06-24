# pdf-analyzer 安装脚本 (Windows)
# 用法: .\install-pdftoppm.ps1

$ErrorActionPreference = "Stop"
Write-Host "=== pdf-analyzer 安装脚本 ===" -ForegroundColor Cyan

$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Resolve-Path (Join-Path $scriptRoot "..")
Set-Location $repoRoot

$pythonCmd = (Get-Command python -ErrorAction SilentlyContinue)?.Source
if (-not $pythonCmd) {
    $pythonCmd = (Get-Command py -ErrorAction SilentlyContinue)?.Source
}

if (-not $pythonCmd) {
    Write-Error "未找到 python 可执行文件。请先安装 Python 并确保 python 或 py 在 PATH 中。"
    exit 1
}

Write-Host "安装 Python 依赖..." -ForegroundColor Cyan
& $pythonCmd -m pip install -r requirements.txt
& $pythonCmd -m pip install -e .
Write-Host "Python 依赖安装完成。" -ForegroundColor Green

Write-Host "检查 pdftoppm..." -ForegroundColor Cyan
$existing = Get-Command pdftoppm -ErrorAction SilentlyContinue
if ($existing) {
    Write-Host "pdftoppm 已安装: $($existing.Source)" -ForegroundColor Green
    pdftoppm -v 2>&1 | Select-Object -First 1
    exit 0
}

$winget = Get-Command winget -ErrorAction SilentlyContinue
if ($winget) {
    Write-Host "通过 winget 安装 Poppler..." -ForegroundColor Yellow
    winget install oschwartz10612.Poppler --accept-source-agreements --accept-package-agreements
    Write-Host "安装完成！请重新打开终端使 PATH 生效。" -ForegroundColor Green
    Write-Host "或者将以下路径加入 PATH: `$env:LOCALAPPDATA\Microsoft\WinGet\Packages\oschwartz10612.Poppler_*\Library\bin" -ForegroundColor Gray
    exit 0
}

Write-Host "未找到 winget，尝试通过 GitHub 下载..." -ForegroundColor Yellow

$popplerUrl = "https://github.com/oschwartz10612/poppler-windows/releases/latest"
$installDir = "$env:USERPROFILE\poppler"

Write-Host ""
Write-Host "pdftoppm 未安装，自动安装失败，请手动安装：" -ForegroundColor Red
Write-Host "  1. 打开: $popplerUrl" -ForegroundColor White
Write-Host "  2. 下载最新 Release-xx.xx.zip" -ForegroundColor White
Write-Host "  3. 解压到: $installDir" -ForegroundColor White
Write-Host "  4. 将以下路径加入 PATH:" -ForegroundColor White
Write-Host "     $installDir\Library\bin" -ForegroundColor Cyan
Write-Host ""
Write-Host "或安装包管理器后重试:" -ForegroundColor Gray
Write-Host "  winget: 系统自带 (Win10 1809+)" -ForegroundColor Gray
Write-Host "  scoop:  Set-ExecutionPolicy RemoteSigned -Scope CurrentUser; irm get.scoop.sh | iex" -ForegroundColor Gray
