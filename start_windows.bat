# ============================================================================
# Uncensored AI Workshop — Start GUI
# ============================================================================
# Double-click this file, or run manually:
#   start_windows.bat
# From the project directory. Opens TextGen's GUI at http://127.0.0.1:7860
# ============================================================================

@echo off
setlocal enabledelayedexpansion

@rem environment isolation
set PYTHONNOUSERSITE=1
set PYTHONPATH=
set PYTHONHOME=
set PYTHONUTF8=1

cd /D "%~dp0"

@rem Portable install case — use bundled python
if exist "portable_env" (
    .\.portable_env\python.exe server.py --portable --api --auto-launch %*
    exit /b %errorLevel%
)

@rem It is recommended to install your own Python environment if the
@rem portable installation does not work, or adjust the path to your
@rem environment.

set PATH=%PATH%;%SystemRoot%\system32

echo.
echo   Uncensored AI Workshop
echo   Starting TextGen GUI server...
echo.

@rem Launch the GUI (browser auto-opens at http://127.0.0.1:7860)
python server.py --portable --api --auto-launch %*

endlocal
