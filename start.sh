#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
PIDFILE="$DIR/.slidev.pid"

if [[ -f "$PIDFILE" ]] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
  echo "Slidev already running (PID $(cat "$PIDFILE")) at http://localhost:3030/"
  exit 0
fi

cd "$DIR"

if [[ ! -d node_modules/@slidev ]]; then
  echo "Installing dependencies..."
  npm install --silent
fi

npx slidev slides.md --open &
PID=$!
echo "$PID" > "$PIDFILE"
echo "Slidev started (PID $PID) at http://localhost:3030/"
