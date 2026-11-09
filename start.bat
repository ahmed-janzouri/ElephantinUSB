@echo off
setlocal enabledelayedexpansion

:: 1. Set USB Root and Paths
set "PORTABLE_ROOT=%~dp0"
if "%PORTABLE_ROOT:~-1%"=="\" set "PORTABLE_ROOT=%PORTABLE_ROOT:~0,-1%"

set "OLLAMA_DIR=%PORTABLE_ROOT%\ollama"
set "OLLAMA_EXE=%OLLAMA_DIR%\ollama.exe"
set "MODELS_DIR=%PORTABLE_ROOT%\models"
set "MODELFILE_PATH=%PORTABLE_ROOT%\Modelfile"

:: 2. Environment Variables for Isolation
set "OLLAMA_LIBRARY_PATH=%OLLAMA_DIR%"
set "OLLAMA_HOST=127.0.0.1:11434"
set "OLLAMA_ORIGINS=*"
set "OLLAMA_MODELS=%MODELS_DIR%"

echo ===================================================
echo        ELEPHANTINUSB - PORTABLE ENGINE
echo ===================================================
echo [!] USB Root: %PORTABLE_ROOT%

:: 3. Validation Checks
if not exist "%OLLAMA_EXE%" (
    echo [ERROR] Missing ollama.exe inside \ollama\ folder! Run setup.bat first.
    goto end_pause
)

if not exist "%MODELFILE_PATH%" (
    echo [ERROR] Missing Modelfile on root!
    goto end_pause
)

:: 4. Start Ollama Server in Background
echo [!] Starting offline AI engine...
cd /d "%OLLAMA_DIR%"
start "ElephantinUSB Server" /B "%OLLAMA_EXE%" serve

:: 5. Wait for API to respond
echo [!] Waiting for engine ready state...
:wait_loop
timeout /t 2 /nobreak >nul
curl -s http://127.0.0.1:11434/ >nul
if errorlevel 1 goto wait_loop

:: 6. Register Model
echo [!] Registering model 'elephantin-ai'...
"%OLLAMA_EXE%" create elephantin-ai -f "%MODELFILE_PATH%"

:: 7. Launch UI
echo [!] Launching User Interface...
start "" "%PORTABLE_ROOT%\index.html"

echo [!] ElephantinUSB is running successfully! You can use the chat interface.
exit /b 0

:end_pause
echo.
echo ===================================================
echo Press any key to exit...
pause >nul