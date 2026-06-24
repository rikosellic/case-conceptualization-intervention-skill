#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

if command -v python >/dev/null 2>&1; then
  PYTHON_CMD=python
elif command -v python3 >/dev/null 2>&1; then
  PYTHON_CMD=python3
else
  echo "未找到 python，可执行文件。请先安装 Python 并确保 python 或 python3 在 PATH 中。" >&2
  exit 1
fi

echo "安装 Python 依赖..."
"$PYTHON_CMD" -m pip install -r requirements.txt
"$PYTHON_CMD" -m pip install -e .
echo "Python 依赖安装完成。"

echo "检查 pdftoppm..."
if command -v pdftoppm >/dev/null 2>&1; then
  echo "pdftoppm 已安装: $(command -v pdftoppm)"
  pdftoppm -v | head -n 1
  exit 0
fi

if command -v apt-get >/dev/null 2>&1; then
  echo "通过 apt-get 安装 Poppler..."
  sudo apt-get update
  sudo apt-get install -y poppler-utils
  exit 0
fi

if command -v yum >/dev/null 2>&1; then
  echo "通过 yum 安装 Poppler..."
  sudo yum install -y poppler-utils
  exit 0
fi

if command -v dnf >/dev/null 2>&1; then
  echo "通过 dnf 安装 Poppler..."
  sudo dnf install -y poppler-utils
  exit 0
fi

if command -v pacman >/dev/null 2>&1; then
  echo "通过 pacman 安装 Poppler..."
  sudo pacman -Syu --noconfirm poppler
  exit 0
fi

echo "未检测到受支持的 Linux 包管理器，请手动安装 pdftoppm。"
echo "你可以使用系统包管理器安装 poppler-utils，或访问 https://poppler.freedesktop.org/ 进行下载。"
exit 1
