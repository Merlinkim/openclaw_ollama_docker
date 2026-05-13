#!/bin/sh
set -eu

MODEL="${OLLAMA_MODEL:-gemma4:e4b}"

# Start Ollama server in background.
ollama serve &
OLLAMA_PID=$!

# Ensure cleanup if container stops.
cleanup() {
  kill "$OLLAMA_PID" 2>/dev/null || true
}
trap cleanup INT TERM

# Wait for Ollama API before pulling the model.
until ollama list >/dev/null 2>&1; do
  sleep 2
done

# Idempotent: if model already exists this is a no-op.
ollama pull "$MODEL"

# Keep container running with Ollama server process.
wait "$OLLAMA_PID"
