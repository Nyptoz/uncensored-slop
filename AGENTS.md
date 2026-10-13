# AGENTS.md — Uncensored AI Workshop

## Project overview
A GUI + CLI workspace for running **uncensored local AI models on ~4 GB RAM**, using:
- **Oobabooga TextGen** (Python) as the inference server
- **llama.cpp** backend (prebuilt binaries, no C++ compiler needed)
- Browser GUI at `http://127.0.0.1:7860`

## Workspace layout
```
uncensored-ai/
├── server.py                 # TextGen server + browser GUI
├── start_windows.bat         # Windows launcher
├── start_gui.sh              # Linux/macOS launcher
├── package.json              # npm scripts
├── README.md                 # Documentation
├── user_data/
│   ├── models/               # Uncensored GGUF models (gitignored)
│   ├── CMD_FLAGS.txt         # Memory-safe defaults
│   └── presets/              # Model presets
└── mcp/                      # MCP tool-call server stack
```

## Running the workspace
- **Windows:** `start_windows.bat`
- **Linux/macOS:** `./start_gui.sh`
- **CLI/API mode:** `python server.py --portable --api --auto-launch`

## Memory-safe defaults (< 4 GB)
| Setting | Value |
|---|---|
| ctx-size | 4096 |
| threads | 6 (physical cores) |
| gpu-layers | 0 (CPU-only) |
| model | 1B-class quantized GGUF |

## Recommended model
- **Qwen2.5-Coder-7B-Instruct-abliterated Q4_K_M** — code-specialized + uncensored
- Download: `https://huggingface.co/bartowski/Qwen2.5-Coder-7B-Instruct-abliterated-GGUF/resolve/main/Qwen2.5-Coder-7B-Instruct-abliterated-Q4_K_M.gguf`

## MCP tool-call server stack (mcp/servers.sh)
- **mcp-server-filesystem** (npx) — file read/write, search, directory
- **mcp-server-git** (uvx) — git status, diff, log, branch, commit
- **Serena** (uv) — semantic code understanding via language servers
- Install: `./mcp/servers.sh`

## Git workflow
- Remote: `https://github.com/Nyptoz/uncensored-slop.git` (main)
- Commit: `git add <files> && git commit -m "message" && git push`
- Large `.gguf` model files are gitignored

## Security notes
- MCP server file access is scoped to the project `cwd`
- CLI/shell executions require approval (`permission: {bash: "ask"}`)
- Treat model outputs as untrusted; review code and run tests
