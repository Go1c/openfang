#!/bin/sh
set -e

OPENFANG_HOME="${OPENFANG_HOME:-/data}"
CONFIG_FILE="$OPENFANG_HOME/config.toml"

mkdir -p "$OPENFANG_HOME"

# Generate config.toml from environment variables if not already present
if [ ! -f "$CONFIG_FILE" ]; then
    PORT="${PORT:-4200}"

    cat > "$CONFIG_FILE" << TOML
# Auto-generated for Zeabur deployment

api_listen = "0.0.0.0:${PORT}"

[default_model]
provider = "${OPENFANG_PROVIDER:-anthropic}"
model = "${OPENFANG_MODEL:-claude-sonnet-4-20250514}"
api_key_env = "ANTHROPIC_API_KEY"

[memory]
decay_rate = 0.05

[network]
listen_addr = "0.0.0.0:4200"
TOML

    echo "[entrypoint] Generated config at $CONFIG_FILE"
fi

exec openfang "$@"
