#!/usr/bin/env bash
# ============================================================================
# Uncensored AI Workshop — Start GUI
# ============================================================================
# Run with:  ./start_gui.sh
# Opens TextGen's browser GUI at http://127.0.0.1:7860
# ============================================================================

set -euo pipefail

# Environment isolation
export PYTHONNOUSERSITE=1
export PYTHONPATH=
export PYTHONHOME=
export PYTHONUTF8=1

cd "$(dirname "$0")"

# Use a bundled conda environment if present
if [[ -d "portable_env" ]]; then
    echo "Using bundled portable environment..."
    # shellcheck source=./portable_env/bin/activate
    # source "./portable_env/bin/activate"
    "$PWD/portable_env/bin/python" server.py --portable --api --auto-launch "$@"
    exit $?
fi

echo ""
echo "  Uncensored AI Workshop"
echo "  Starting TextGen GUI server..."
echo ""

# Launch the GUI (browser auto-opens at http://127.0.0.1:7860)
python server.py --portable --api --auto-launch "$@"
