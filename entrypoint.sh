#!/bin/sh
set -e

OPENFANG_HOME="${OPENFANG_HOME:-/data}"
CONFIG_FILE="$OPENFANG_HOME/config.toml"

mkdir -p "$OPENFANG_HOME"

if [ ! -f "$CONFIG_FILE" ]; then
    PORT="${PORT:-4200}"

    cat > "$CONFIG_FILE" << TOML
# Auto-generated for Zeabur deployment

api_listen = "0.0.0.0:${PORT}"

[default_model]
provider = "openrouter"
model = "${OPENFANG_MODEL:-openai/gpt-4o}"
api_key_env = "OPENROUTER_API_KEY"

[memory]
decay_rate = 0.05

[network]
listen_addr = "0.0.0.0:4200"
TOML

    echo "[entrypoint] Generated config at $CONFIG_FILE"
fi

exec openfang "$@"
