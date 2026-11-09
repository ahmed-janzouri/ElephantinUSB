# 🐘 ElephantinUSB

> **Your secure, portable, offline-first AI companion.** Run a powerful local LLM directly from any USB drive with complete data privacy and zero cloud connection.

---

## ⚠️ Important USB Installation Notice
The initial setup (`setup.bat`) downloads the AI engine and model weights directly to your USB drive. **Depending on your USB write speed (USB 2.0 vs USB 3.0/3.1) and flash drive performance, the installation can take anywhere from 10 to 30 minutes.** Please keep your USB plugged in and do not close the window until the process finishes.

---

## 💻 System Recommendations
To run ElephantinUSB smoothly, your PC should meet these minimum requirements:
* **OS**: Windows 10 / 11 (64-bit)
* **RAM**: 8GB minimum (16GB recommended for faster token generation)
* **Storage**: At least 5GB–10GB of free space on your USB drive
* **Graphics**: Integrated graphics work fine; a dedicated GPU (Nvidia/AMD) speeds up performance.

---

## 🤖 Understanding the 3 Types of AI Models
AI models generally fall into three categories based on how they process data and handle tasks:

1. **Small / Edge Models (e.g., Llama 3.2 3B)**
   * *What they are*: Lightweight models designed for speed and low memory usage.
   * *Best for*: Running portably on USB drives, fast answers, general chat, and basic coding tasks on everyday hardware. (This is what ElephantinUSB uses by default).
2. **Mid-Size / General-Purpose Models (e.g., 7B – 8B parameters)**
   * *What they are*: More capable models requiring more RAM/VRAM.
   * *Best for*: Deep reasoning, complex coding, creative writing, and nuanced multi-turn conversations.
3. **Specialized / Domain Models (e.g., Coding or Medical fine-tunes)**
   * *What they are*: Models trained heavily on specific industries or languages.
   * *Best for*: High accuracy within a single specialized field (like Python scripting or cybersecurity analysis) rather than general chat.

---

## 🚀 Quick Start Guide

1. **Setup**: Double-click **`setup.bat`** on a Windows machine and let it finish (remember it may take a while depending on your USB speed).
2. **Launch**: Double-click **`start.bat`** to boot the local offline server and open the web chat interface automatically.
3. **Chat**: Enjoy your secure, air-gapped AI!

---

## 🛠️ File Structure
```text
E:\ElephantinUSB\
├── 📂 assets\          # Custom branding & logo (logo.png)
├── 📂 models\          # Local GGUF model storage
├── 📂 ollama\          # Portable Ollama server binaries
├── index.html          # Clean web chat interface
├── Modelfile           # Model prompt configuration
├── README.md           # Documentation
├── setup.bat           # Setup wizard launcher
├── setup.ps1           # Automated dependency installer script
└── start.bat           # Main engine & UI bootstrapper