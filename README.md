# QualiEdge (Edge-RCA)
### Real-Time Edge Industrial Defect Detection & Llama+ExecuTorch Quality Management

![Challenge](https://img.shields.io/badge/Bharat%20AI%20SoC%20Challenge-2026--27-1e3a8a?style=flat-square)
![Status](https://img.shields.io/badge/Phases%20Completed-13%2F13%20Verified-16a34a?style=flat-square)
![Edge Target](https://img.shields.io/badge/Edge%20Target-RPi%205%20%2B%20Hailo--8L-0d9488?style=flat-square)
![Vision](https://img.shields.io/badge/Vision-YOLOv8n%20INT8%20(58.8%20FPS)-2563eb?style=flat-square)
![Reasoning](https://img.shields.io/badge/Reasoning-Llama%203.2%201B%20(ExecuTorch)-ea580c?style=flat-square)
![Execution](https://img.shields.io/badge/Execution-100%25%20Offline%20Air--Gapped-0f172a?style=flat-square)

**QualiEdge (Edge-RCA)** is a 100% offline, dual-engine Edge AI industrial quality-control and root-cause analysis platform built for **Manufacturing & Industry 4.0 (Bharat AI SoC Challenge 2026–27)**.

Traditional factory inspection cameras act only as passive reject bins—they flag surface flaws without explaining *why* they happened or how to fix upstream machinery. Conversely, running a Large Language Model (LLM) directly alongside a high-speed camera feed on an edge device causes severe frame drops.

QualiEdge solves both problems by uniting **high-speed YOLOv8n vision inference on Hailo-8L / Arm Cortex-A76** with **on-device ExecuTorch Llama 3.2 1B metallurgical reasoning**, complete with a live HMI dashboard, SQLite WAL persistence, and ISO 9001 certified reporting.

---

## System Architecture

QualiEdge decouples fast visual inspection from deep LLM reasoning using an asynchronous **64-slot lossless FIFO ring buffer** and **SQLite WAL (Write-Ahead Logging)** database. The vision pipeline passes only **structured JSON defect telemetry** (defect class, severity, bounding box coordinates, surface area ratio, and confidence)—never raw pixels—to Llama 3.2.

```text
[1. Raw Acquisition Frame (1080p @ 30 FPS / Webcam / Upload / Presets)]
        │
        ▼  Core 0: OpenCV Preprocessing (CLAHE: Clip 2.5 | 8x8 Grid)
[2. Specular Glare Suppressed Frame]
        │
        ▼  Core 1 + Hailo-8L NPU (PCIe Gen 2.0 Zero-Copy DMA)
[3. Fast-Path Vision: INT8 YOLOv8n] ──► 11.45 ms | 58.8 FPS (65+ FPS Edge)
        │
        ▼
[Section 7 Fail-Safe Gate]
   ├── Confidence < 0.65 ──► Route to Human Manual Review
   └── Confidence >= 0.65 ─► Structured Telemetry JSON ──► [64-Slot FIFO Buffer + SQLite WAL (Core 2)]
                                                                   │
                                                                   ▼
                                                  [Deep-Path Reasoning (Core 3)]
                                                  Llama 3.2 1B Instruct via ExecuTorch (Arm XNNPACK 4-bit)
                                                                   │  138.4 ms (Zero Frame Drops)
                                                                   ▼
                                                  [Live Operator HMI + Metallurgical Action Plan + ISO 9001 CSV]