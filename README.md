# Uncensored AI Workshop

A lightweight, GUI-friendly workspace for running **uncensored local models** on consumer hardware, tuned for **~4 GB RAM**.

Runs on **Oobabooga TextGen** (Python) + **llama.cpp** backend, with a browser-based GUI and an API for programmatic use.

The portable requirements bundle a **prebuilt llama.cpp** (`llama_cpp_binaries` wheel) — so no C++ compiler is needed. It includes CPU-only and CUDA variants for better speed when you have a GPU.

---

## Quick Start

### Windows
Double-click **`start_windows.bat`**, or run in a terminal:
```bat
start_windows.bat
```
The browser GUI opens at **http://127.0.0.1:7860**.

### Linux / macOS
```bash
chmod +x start_gui.sh
./start_gui.sh
```
The browser GUI opens at **http://127.0.0.1:7860**.

### CLI mode (no browser)
```bash
python server.py --portable --api --port 7860
```

---

## How It Works (Memory-Safe by Design)

| Setting | Value | Reason |
|---|---|---|
| **Context size** | `4096` tokens | Context is preallocated; smaller ctx = less RAM |
| **Threads** | Physical cores (6) | Efficient CPU inference |
| **LaTeX / GPU layers** | `0` | CPU-only, no VRAM needed |
| **Cache type** | `1` (kvcache) | Default, memory-safe |

Adjust in `user_data/CMD_FLAGS.txt` or in the GUI's **Model tab**.

---

## Choosing an Uncensored Model

1. Download a **single GGUF** file of an uncensored model (e.g., TinyDolphin 1.1B, Lexi 8B).
2. Place it in **`user_data/models/`**.
3. Set **`MODEL_FILE`** in `user_data/CMD_FLAGS.txt` to the filename (without path).
4. Restart the server.

> GGUF model files are **not** the full runtime footprint — inference also needs RAM for context and buffers. A 1.1B Q4 model (~668 MB file) is the realistic target under 4 GB total RAM. An 8B model needs ~16 GB at full precision; even Q4_K_M leaves little room beyond the weights. The prebuilt llama.cpp binary is kept lean and makes CPU inference efficient.

---

## File Layout

```
uncensored-ai/
├── server.py                 # TextGen server + browser GUI
├── start_windows.bat         # Windows launcher
├── start_gui.sh              # Linux/macOS launcher
├── package.json              # npm scripts (optional)
├── README.md                 # This file
└── user_data/
    ├── models/               # Place your GGUF model here
    ├── CMD_FLAGS.txt         # Settings (ctx-size, threads, model file)
    ├── presets/              # Model presets
    ├── users/                # Chat state / users
    └── extensions/           # Extensions to load
```

---

## Graphics / Acceleration Options (if you have a GPU)

- **NVIDIA CUDA**: install the CUDA variant of the binary wheel (`requirements/cuda131.txt`) or keep CPU-only. Set `--gpu-layers N` (try 35).
- **AMD**: use HIP/ROCm or Vulkan builds.
- **Intel/other**: Vulkan or SYCL backend (check your hardware support).
- If you lack a supported GPU, CPU-only is still viable — just keep context modest.

---

## Notes

- "Uncensored" describes the model's training/alignment. It will not guarantee refusal-free answers, and you are responsible for what you generate.
- Check the model's license before use.
- For < 4 GB total RAM, a **1B-class quantized model** is the safe target.
