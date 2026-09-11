#!/usr/bin/env bash
set -euo pipefail

show_help() {
  cat << 'HELP'
Usage: ./scripts/setup.sh [PROFILE]

Sets up global AI agent configuration symlinks via GNU Stow for Linux/macOS.

Available Profiles:
  personal    (Default) Links personal rules (Gemini CLI, GitHub Copilot).
  enterprise  Links enterprise/corporate rules for Acme Corp (Gemini CLI, GitHub Copilot, AWS Kiro).
              Aliases: work, acme

Options:
  -h, --help  Show this help message and exit.

Examples:
  ./scripts/setup.sh
  ./scripts/setup.sh personal
  ./scripts/setup.sh enterprise
HELP
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  show_help
  exit 0
fi

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROFILE="${1:-personal}"

if ! command -v stow >/dev/null 2>&1; then
  echo "Error: GNU Stow is not installed." >&2
  echo "Please install it using your package manager (e.g. 'sudo apt install stow' or 'brew install stow')." >&2
  exit 1
fi

echo "Setting up AI Agent configurations for profile: '$PROFILE' via GNU Stow..."

cd "$REPO_ROOT"

case "$PROFILE" in
  enterprise|work|acme)
    STOW_DIR="enterprise"
    stow --dir="$STOW_DIR" --restow -v -t ~ gemini
    stow --dir="$STOW_DIR" --restow -v -t ~ copilot
    stow --dir="$STOW_DIR" --restow -v -t ~ kiro
    ;;
  personal|default)
    STOW_DIR="."
    stow --dir="$STOW_DIR" --restow -v -t ~ gemini
    stow --dir="$STOW_DIR" --restow -v -t ~ copilot
    ;;
  *)
    echo "Error: Unknown profile '$PROFILE'." >&2
    echo "Available profiles: personal, enterprise (aliases: work, acme)." >&2
    echo "Run './scripts/setup.sh --help' for details." >&2
    exit 1
    ;;
esac

echo "Setup complete! Symlinks successfully created for profile '$PROFILE'."
