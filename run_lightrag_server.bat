@echo off
setlocal

echo ============================================
echo [LightRAG] Start server (API + WebUI)
echo ============================================

if not exist ".venv\Scripts\activate.bat" (
  echo [ERROR] .venv not found.
  echo Please run install_lightrag_env.bat first.
  exit /b 1
)

echo [1/4] Activating virtual environment...
call ".venv\Scripts\activate.bat"
if errorlevel 1 (
  echo [ERROR] Failed to activate .venv
  exit /b 1
)

if not exist ".env" (
  echo [ERROR] .env file not found in current directory.
  echo Please create it first, for example:
  echo   copy env.example .env
  echo or
  echo   copy .env.windows.example .env
  exit /b 1
)

echo [2/4] .env found.
echo [3/4] Starting lightrag-server...
echo [INFO] Press Ctrl+C to stop.

echo [4/4] Running command: lightrag-server
lightrag-server
set ERR=%ERRORLEVEL%

if not "%ERR%"=="0" (
  echo [ERROR] lightrag-server exited with code %ERR%
  exit /b %ERR%
)

echo [SUCCESS] lightrag-server exited normally.
endlocal
exit /b 0
