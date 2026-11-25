# QualiEdge Dual-Engine Launcher (PowerShell)
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $ScriptDir

Write-Host "=====================================================================" -ForegroundColor Cyan
Write-Host "   QualiEdge: Real-Time Edge Industrial Defect Detection Launcher     " -ForegroundColor Green
Write-Host "   Dual-Engine YOLOv8n + ExecuTorch Llama 3.2 + Industrial React HMI  " -ForegroundColor White
Write-Host "=====================================================================" -ForegroundColor Cyan

$PythonExe = "python"
if (Test-Path "C:\Users\ME\AppData\Roaming\uv\python\cpython-3.11.17-windows-x86_64-none\python.exe") {
    $PythonExe = "C:\Users\ME\AppData\Roaming\uv\python\cpython-3.11.17-windows-x86_64-none\python.exe"
}

Write-Host "`n[1/3] Starting Python Edge Backend API on Port 8000..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit", "-Command", "& '$PythonExe' backend/main.py"

Write-Host "[2/3] Starting React HMI Frontend on Port 3000..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit", "-Command", "npm run dev"

Start-Sleep -Seconds 3

Write-Host "`n=====================================================================" -ForegroundColor Cyan
Write-Host "   System active! Opening browser at http://localhost:3000/QualiEdge/" -ForegroundColor Green
Write-Host "=====================================================================" -ForegroundColor Cyan

Start-Process "http://localhost:3000/QualiEdge/"
