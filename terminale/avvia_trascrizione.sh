#!/usr/bin/env bash
# Linux: avvia trascrizione da terminale (progetto "Generale"), senza dashboard.
set -euo pipefail
cd "$(dirname "$(readlink -f "$0")")/.."
[ -f .env ] || { cp .env.example .env; echo "Creato .env: inserisci le API key e rilancia."; exit 1; }
{ [ -d .venv ] && .venv/bin/python -m pip --version >/dev/null 2>&1; } || { rm -rf .venv; python3 -m venv .venv || { echo "Ubuntu/Mint: sudo apt install python3-venv python3-pip" >&2; exit 1; }; }
.venv/bin/python -c "import fastapi, soundfile, groq, openai, faster_whisper, av" 2>/dev/null || .venv/bin/python -m pip install -q -r requirements.txt
exec .venv/bin/python src/trascrittore.py "$@"
