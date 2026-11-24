@echo off
title QualiEdge Industrial Edge System
echo ===================================================
echo   QualiEdge - Industrial Defect Detection System
echo   Launching Dual-Engine Inference ^& HMI Dashboard...
echo ===================================================

echo [1/2] Starting Edge Inference API Server on port 8000...
start "QualiEdge API" python backend/main.py

timeout /t 3 /nobreak >nul

echo [2/2] Starting Vite React Dashboard on port 3000...
start "QualiEdge Dashboard" cmd /c "npm run dev"

echo.
echo All services launched!
echo Access HMI Dashboard at: http://localhost:3000/QualiEdge/
echo Access Edge API Docs at: http://localhost:8000/docs
echo ===================================================
pause
