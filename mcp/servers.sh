#!/usr/bin/env bash
# ============================================================================
# Uncensored AI Workshop — MCP Server Setup
# ============================================================================
# Installs the MCP tool-call server stack for an OpenCode-like experience.
#
# Stack:
#   - mcp-server-filesystem    (file read/write, search, directory tools)
#   - mcp-server-git           (git status, diff, log, branch, commit tools)
#   - Serena                   (semantic code understanding via LSP)
#
# Prerequisites:
#   - Node.js (for npx: filesystem server)
#   - uvx/uv (for mcp-server-git)
#   - uv (for Serena)
# ============================================================================

set -euo pipefail

echo "=== MCP Server Setup for Uncensored AI Workshop ==="
echo ""

# Detect OS
OS="$(uname -s)"
case "${OS}" in
    Linux*)     MACHINE="linux";;
    Darwin*)    MACHINE="macos";;
    MINGW*|MSYS*) MACHINE="windows";;
    *)          echo "Unknown OS: ${OS}"; exit 1;;
esac

echo "Detected OS: ${OS} (${MACHINE})"
echo ""

# 1. Install uv (for Serena and git server)
echo "--- Step 1: Installing uv ---"
if ! command -v uv &> /dev/null; then
    echo "Installing uv..."
    if [[ "${MACHINE}" == "windows" ]]; then
        powershell -ExecutionPolicy Bypass -c "irm https://astral.sh/uv/install.ps1 | iex"
    else
        curl -LsSf https://astral.sh/uv/install.sh | sh
    fi
    export PATH="$HOME/.cargo/bin:$PATH"
    echo "uv installed."
else
    echo "uv already installed."
fi
echo ""

# 2. Install mcp-server-git via uvx
echo "--- Step 2: Installing mcp-server-git ---"
if ! command -v uvx &> /dev/null; then
    echo "Installing uvx..."
    uv tool install uv
fi
echo "uvx ready."
echo ""

# 3. Install Serena (optional, for semantic code understanding)
echo "--- Step 3: Installing Serena (optional) ---"
if ! command -v serena &> /dev/null; then
    echo "Installing Serena..."
    uv tool install serena-agent -p 3.13
    echo "Serena installed."
else
    echo "Serena already installed."
fi
echo ""

# 4. Verify installations
echo "--- Step 4: Verifying installations ---"
for cmd in npx uv uvx node python3; do
    if command -v "${cmd}" &> /dev/null; then
        echo "  OK: ${cmd} ($(command -v ${cmd}))"
    else
        echo "  MISSING: ${cmd}"
    fi
done
echo ""

echo "=== Setup complete ==="
echo ""
echo "Next steps:"
echo "  1. Create a project-level opencode.json (or use the workspace config)"
echo "  2. Add MCP server configurations to the 'mcp' section"
echo "  3. Launch OpenCode in the project directory"
echo ""
echo "Example opencode.json:"
echo '{
  "mcp": {
    "filesystem": {
      "type": "local",
      "command": ["npx", "-y", "@modelcontextprotocol/server-filesystem",
                  "/absolute/path/to/project"
      ],
      "enabled": true
    },
    "git": {
      "type": "local",
      "command": ["uvx", "mcp-server-git", "--repository", "/absolute/path/to/project"],
      "enabled": true
    }
  },
  "lsp": true,
  "permission": {
    "edit": "ask",
    "bash": "ask",
    "filesystem_*": "ask",
    "git_*": "ask"
  }
}'
