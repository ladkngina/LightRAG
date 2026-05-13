@echo off
setlocal

echo ============================================
echo [LightRAG] Windows dependency installer
echo ============================================

echo [1/3] Checking uv availability...
where uv >nul 2>nul
if errorlevel 1 (
  echo [ERROR] uv is not found in PATH.
  echo Please install uv first, then reopen terminal.
  echo Official install command (PowerShell):
  echo   powershell -c "irm https://astral.sh/uv/install.ps1 ^| iex"
  exit /b 1
)

echo [OK] uv found.
uv --version

echo [2/3] Installing dependencies with uv sync...
uv sync --extra test --extra offline
if errorlevel 1 (
  echo [ERROR] uv sync failed. Please check network/Python environment.
  exit /b 1
)

echo [3/3] Done.
echo [SUCCESS] Dependencies installed. Virtual environment should be in .venv

echo NOTE: This script does NOT write any API key.
echo Please configure .env manually.

endlocal
exit /b 0
