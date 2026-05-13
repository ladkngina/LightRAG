@echo off
setlocal

echo ============================================
echo [LightRAG] Run official OpenAI demo
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

echo [2/4] Checking OPENAI_API_KEY...
if "%OPENAI_API_KEY%"=="" (
  echo [ERROR] OPENAI_API_KEY is not set in current cmd session.
  echo Please set it first, for example:
  echo   set OPENAI_API_KEY=your_openai_api_key
  exit /b 1
)

echo [3/4] OPENAI_API_KEY is set.
if not exist "book.txt" (
  echo [WARN] book.txt not found in current directory.
  echo Demo may fail if the file is required.
  echo You can download it with:
  echo   curl https://raw.githubusercontent.com/gusye1234/nano-graphrag/main/tests/mock_data.txt -o book.txt
)

echo [4/4] Running demo: python examples\lightrag_openai_demo.py
python examples\lightrag_openai_demo.py
set ERR=%ERRORLEVEL%

if not "%ERR%"=="0" (
  echo [ERROR] Demo exited with code %ERR%
  exit /b %ERR%
)

echo [SUCCESS] Demo finished.
endlocal
exit /b 0
