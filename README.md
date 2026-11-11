# 🐘 ElephantinUSB

> **Your secure, portable, offline-first AI companion.** Run a powerful local LLM directly from any USB drive with complete data privacy and zero cloud connection[cite: 9].

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/Version-0.5.0--beta-green.svg)](https://github.com/ahmed-janzouri/PocketIntelligence/releases)

---

## 📖 The Story Behind the Name

The name **ElephantinUSB** comes from a simple metaphor: the elephant is a massive, highly intelligent, and sensible animal equipped with an unbelievable memory—yet all of that intelligence is packed into a tiny, portable USB drive you can carry in your pocket[cite: 1]. It brings heavy-duty local intelligence anywhere you go, 100% offline[cite: 1, 9].

---

## 📥 Important USB Setup Instructions

1. **Copy & Extract**: Download the project ZIP file, **copy it directly onto your USB flash drive**, and extract the contents into your USB root folder before running any scripts.
2. **Setup Time**: Double-click `setup.bat` to launch the setup wizard[cite: 9]. Depending on your flash drive speeds (USB 2.0 vs. USB 3.0/3.1)[cite: 9], the initial download and setup can take **10 to 30 minutes**[cite: 9]. Please keep your USB drive plugged in and do not close the window until installation completes[cite: 9].

---

## 🧠 Why Llama 3.2 3B?

By default, ElephantinUSB utilizes **Llama 3.2 3B (Q4_K_M)**[cite: 8, 9]. We selected this model for its exceptional balance of speed, footprint, and intelligence[cite: 9]:

* **Incredible Performance & Speed**: Optimized for fast token generation on everyday consumer hardware without requiring heavy cloud compute or dedicated GPUs[cite: 9].
* **High Customizability & Tuning**: Easily tailored with system prompts and custom parameters via the included `Modelfile`[cite: 8, 9].
* **Open-Source & Air-Gapped**: Guarantees complete data privacy with zero telemetry, cloud logging, or external tracking[cite: 1, 9].

---

## 🚀 Quick Start

1. **Install**: Run `setup.bat` on any Windows PC to launch the graphical installer and download required local binaries[cite: 9, 11].
2. **Launch**: Double-click `start.bat` to spin up the isolated local AI engine and launch the web chat interface[cite: 9, 12].
3. **Chat**: Enjoy your secure, air-gapped AI companion![cite: 9]

---

## 🗺️ Upcoming Features & Roadmap

ElephantinUSB is designed with emergency preparedness and field resilience in mind[cite: 1]. Active development is underway for:

* 🩺 **Offline Emergency Medical Reference**: Trusted first-aid manuals and triage documentation for grid failures or remote field use[cite: 1].
* ⚡ **Wiring & Technical Schematics**: Integrated electrical wiring diagrams and troubleshooting guides for emergency systems[cite: 1].
* 🐧 **Cross-Platform Support**: Launcher scripts for Linux (`.sh`) and macOS (`.command`).

---

## 💻 System Requirements

* **OS**: Windows 10 / 11 (64-bit)[cite: 9]
* **RAM**: 8GB minimum (16GB recommended for optimal generation speeds)[cite: 9]
* **Storage**: 5GB–10GB of free space on your USB drive[cite: 9]
* **Hardware**: USB 3.0 / 3.1 Flash Drive or Portable SSD recommended[cite: 3, 9]

---

## 🛠️ File Structure

```text
E:\ElephantinUSB\
├── 📂 assets\          # Logo & visual branding assets (logo.png)
├── 📂 models\          # Local GGUF model storage directory
├── 📂 ollama\          # Standalone Ollama runtime binaries
├── index.html          # Lightweight single-file web chat interface
├── Modelfile           # System prompt & engine parameter configuration
├── README.md           # Project documentation
├── setup.bat           # Launcher for setup wizard
├── setup.ps1           # PowerShell GUI installer script
└── start.bat           # Main offline engine & web interface launcher
```[cite: 9]

---

## 🤝 Community, Ideas & Contributions

ElephantinUSB is open-source under the **MIT License**! Feedback, feature requests, and community contributions are very welcome.

* **Suggestions & Ideas**: Open an issue on GitHub or reach out directly via email at **ahmedjanzouri9@gmail.com**.
* **Contributions**: Feel free to fork the repository and submit pull requests for new launcher features, UI improvements, or prompt tuning!
* **Support**: If you find this project useful and want to support its ongoing development, donations and feedback are greatly appreciated.
