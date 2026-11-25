@echo off
title QualiEdge - Dual Engine System Launcher
echo =====================================================================
echo    QualiEdge: Real-Time Edge Industrial Defect Detection Launcher
echo    Fine-Tuned YOLOv8n + ExecuTorch Llama 3.2 Advisory + React HMI
echo =====================================================================
echo.

cd /d "%~dp0"

echo [1/3] Checking Python environment and Edge API...
if exist "C:\Users\ME\AppData\Roaming\uv\python\cpython-3.11.17-windows-x86_64-none\python.exe" (
    set "PYTHON_EXE=C:\Users\ME\AppData\Roaming\uv\python\cpython-3.11.17-windows-x86_64-none\python.exe"
) else (
    set "PYTHON_EXE=python"
)

echo [2/3] Launching Edge Vision & Metallurgy Backend (Port 8000)...
start "QualiEdge Edge API Backend" cmd /k ""%PYTHON_EXE%" backend/main.py"

echo [3/3] Launching React HMI Dashboard (Port 3000)...
start "QualiEdge HMI Frontend" cmd /k "npm run dev"

timeout /t 3 >nul
echo.
echo =====================================================================
echo   System running!
echo   - Edge API: http://127.0.0.1:8000
echo   - HMI Dashboard: http://localhost:3000/QualiEdge/
echo   - GitHub Pages: https://amitshaw2005.github.io/QualiEdge/
echo =====================================================================
start http://localhost:3000/QualiEdge/
pause
