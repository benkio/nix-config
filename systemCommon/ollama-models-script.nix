{ pkgs, ... }:

# Common script to ensure ollama has at least one model installed
pkgs.writeShellScript "ollama-models" ''
  #!/bin/bash
  # Script to ensure ollama has at least one model installed

  OLLAMA_BIN="${pkgs.ollama}/bin/ollama"
  MAX_WAIT=60
  WAIT_COUNT=0

  # Wait for ollama service to be ready
  while [ $WAIT_COUNT -lt $MAX_WAIT ]; do
    if $OLLAMA_BIN list >/dev/null 2>&1; then
      break
    fi
    sleep 1
    WAIT_COUNT=$((WAIT_COUNT + 1))
  done

  if [ $WAIT_COUNT -ge $MAX_WAIT ]; then
    echo "Ollama service not ready after $MAX_WAIT seconds"
    exit 0
  fi

  # Check if any models are installed (ollama list returns header + models, so >1 means models exist)
  MODEL_COUNT=$($OLLAMA_BIN list 2>/dev/null | tail -n +2 | wc -l | tr -d ' ')

  if [ -z "$MODEL_COUNT" ] || [ "$MODEL_COUNT" -eq 0 ]; then
    echo "No ollama models found. Pulling default model: llama3.2:3b"
    $OLLAMA_BIN pull llama3.2:3b
  else
    echo "Ollama models already installed ($MODEL_COUNT model(s))"
  fi
''
