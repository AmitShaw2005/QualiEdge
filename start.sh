#!/usr/bin/env bash
set -e

echo "==================================================="
echo "  QualiEdge - Industrial Defect Detection System   "
echo "  Target: Edge Device / Linux / Raspberry Pi 5     "
echo "==================================================="

echo "[1/2] Starting Edge Inference API Server on port 8000..."
python3 backend/main.py &
BACKEND_PID=$!

sleep 3

echo "[2/2] Starting React Vite Dashboard on port 3000..."
npm run dev -- --host 0.0.0.0 --port 3000 &
FRONTEND_PID=$!

trap "kill $BACKEND_PID $FRONTEND_PID 2>/dev/null" EXIT

echo ""
echo "QualiEdge Services Active:"
echo " - HMI Dashboard: http://localhost:3000/QualiEdge/"
echo " - REST API:      http://localhost:8000/api/health"
echo "==================================================="
wait
