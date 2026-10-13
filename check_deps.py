#!/usr/bin/env python3
import sys

deps = {
    'markdown': 'markdown',
    'numpy': 'numpy',
    'fastapi': 'fastapi',
    'flask_cloudflared': 'flask_cloudflared',
    'sse_starlette': 'sse_starlette',
    'tiktoken': 'tiktoken',
    'rich': 'rich',
    'pydantic': 'pydantic',
}

all_ok = True
for name, mod in deps.items():
    try:
        __import__(mod)
        print('  OK: ' + name)
    except ImportError as e:
        print('  MISSING: ' + name + ' (' + str(e) + ')')
        all_ok = False

sys.exit(0 if all_ok else 1)
