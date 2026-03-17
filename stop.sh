#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
PIDFILE="$DIR/.slidev.pid"

if [[ ! -f "$PIDFILE" ]]; then
  echo "No Slidev PID file found. Killing any slidev processes..."
  pkill -f slidev 2>/dev/null && echo "Stopped." || echo "Nothing running."
  exit 0
fi

PID="$(cat "$PIDFILE")"
if kill -0 "$PID" 2>/dev/null; then
  kill "$PID"
  echo "Slidev stopped (PID $PID)."
else
  echo "Process $PID not running."
fi
rm -f "$PIDFILE"
