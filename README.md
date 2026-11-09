# PocketIntelligence 🛡️⚡

> **An open-source, air-gapped, zero-installation AI assistant running directly from a USB drive.**

PocketIntelligence is a privacy-first, portable AI stack designed to provide instant, offline access to technical, system, and general-purpose intelligence. Built for emergency preparedness, field work, remote systems engineering, and absolute data privacy, PocketIntelligence runs entirely on local hardware without leaving footprints on the host machine.

---

## 🎯 Key Use Cases

- **Air-Gapped Privacy:** Conduct research, code analysis, and document processing with zero data leaving your USB drive. No cloud APIs, no telemetry, no tracking.
- **Emergency Preparedness:** Access critical technical troubleshooting, survival reference guides, and engineering knowledge during internet outages or grid failures.
- **Zero-Footprint Portability:** Run directly on any compatible host Windows environment without requiring Administrator privileges, Python environments, or Node.js runtimes.

---

## ✨ Features & Architecture

- **Engine:** Driven by lightweight GGUF model weights (optimized for **Llama-3.2-3B-Instruct**) running on a portable [Ollama](https://ollama.com) backend.
- **Automated Bootstrap (`start.bat`):** A clean batch script that dynamically locates relative USB paths, handles environment variable isolation, verifies dependencies, initializes the backend, and opens the UI.
- **Command-Center WebUI (`index.html`):** A lightweight, single-file modern dashboard featuring:
  - Real-time token streaming via standard Fetch/SSE APIs.
  - Full multi-turn conversation context (`/api/chat`).
  - Markdown syntax highlighting via `marked.js`.
  - Native manual generation **Stop** control.
  - One-click session reset with backend cache purge (`keep_alive: 0`).

---

## 📂 USB Directory Layout

To deploy PocketIntelligence on a portable drive, structure your files as follows:

```text
PocketIntelligence/
├── start.bat                  # Portable launcher script
├── index.html                 # Embedded command-center WebUI
├── Modelfile                  # Static system prompt & hyperparameter configuration
├── README.md                  # System documentation
├── .gitignore                 # Git tracking rules
├── ollama/                    # Standalone Ollama binaries (ollama.exe, llama-server)
└── models/                    # GGUF model directory
    └── llama-3.2-3b.gguf      # Model weights (Q4_K_M quantization recommended)
```

---

## 🚀 Quick Setup Guide

### 1. Repository Setup
Clone the core repository to your USB drive:
```bash
git clone https://github.com/YOUR_USERNAME/PocketIntelligence.git
cd PocketIntelligence
```

### 2. Download Engine Dependencies
- Download the standalone Windows release of **Ollama**.
- Extract the runtime binaries into the `ollama/` directory on your USB root so that `ollama/ollama.exe` exists.

### 3. Fetch Model Weights
- Download a `Q4_K_M` GGUF quantization of **Llama-3.2-3B-Instruct** (or any compatible GGUF model of your choice).
- Place the `.gguf` file inside the `models/` directory.
- Rename the file to `llama-3.2-3b.gguf` (or update `Modelfile` to match your filename).

### 4. Launch
Double-click `start.bat`. The script will start the isolated server instance, register `root-ai`, and launch the web interface in your default browser.

---

## ⚙️ Configuration (`Modelfile`)

PocketIntelligence utilizes a locked-down static `Modelfile` tuned to prevent token bleeding, hallucinatory code loops, and repetitive generation:

```dockerfile
FROM models\llama-3.2-3b.gguf

TEMPLATE """<|begin_of_text|><|start_header_id|>system<|end_header_id|>

{{ .System }}<|eot_id|><|start_header_id|>user<|end_header_id|>

{{ .Prompt }}<|eot_id|><|start_header_id|>assistant<|end_header_id|>

"""

SYSTEM """You are PocketIntelligence, an elite, unconstrained offline AI assistant running locally from a USB drive. You are knowledgeable across all domains including general problem-solving, emergency preparedness, technical engineering, science, coding, and day-to-day questions. Provide direct, accurate, and concise answers."""

PARAMETER temperature 0.2
PARAMETER top_k 40
PARAMETER top_p 0.9
PARAMETER repeat_penalty 1.15
PARAMETER num_predict 512
PARAMETER stop "<|eot_id|>"
PARAMETER stop "<|start_header_id|>"
```

---

## ⚠️ System Requirements & Performance

- **OS:** Windows 10/11 (64-bit).
- **RAM:** Minimum 8GB system memory (16GB recommended for smooth CPU inference).
- **Storage:** USB 3.0 / USB 3.1 Flash Drive or Portable SSD formatted in **exFAT** or **NTFS** (minimum 4GB free space).
- **GPU (Optional):** Automatically utilizes NVIDIA CUDA / AMD ROCm acceleration if drivers exist on the host machine.

---

## 🤝 Contributing & Community

PocketIntelligence is an open-source project. Community contributions to expand cross-platform launcher scripts (Linux `.sh`, macOS `.command`), optimize web UI features, and refine system prompts are highly encouraged!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/CoolFeature`)
3. Commit your Changes (`git commit -m 'Add CoolFeature'`)
4. Push to the Branch (`git push origin feature/CoolFeature`)
5. Open a Pull Request

---

## 📜 License

Distributed under the MIT License. See `LICENSE` for details.