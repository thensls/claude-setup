#!/usr/bin/env bash
# NSLS Customer Success — Claude Code setup script
# Run this once on a new machine after installing Claude Code and GitHub CLI.
# Usage: bash setup-cs.sh

set -e

echo ""
echo "=== NSLS Customer Success — Claude Setup ==="
echo ""

# ── 1. Check Claude Code is installed ────────────────────────────────────────
if ! command -v claude &>/dev/null; then
  echo ""
  echo "ERROR: Claude Code is not installed."
  echo "→ Download it from: https://claude.ai/download"
  echo "  Then re-run this script."
  exit 1
fi
echo "✓ Claude Code found"

# ── 2. Check GitHub CLI is installed and authenticated ───────────────────────
if ! command -v gh &>/dev/null; then
  echo ""
  echo "ERROR: GitHub CLI (gh) is not installed."
  echo "→ Download it from: https://cli.github.com"
  echo "  After installing, run: gh auth login"
  echo "  Then re-run this script."
  exit 1
fi

if ! gh auth status &>/dev/null; then
  echo ""
  echo "ERROR: You are not logged into GitHub."
  echo "→ Run this command first: gh auth login"
  echo "  (Choose: GitHub.com → HTTPS → Login with a web browser)"
  echo "  Then re-run this script."
  exit 1
fi
echo "✓ GitHub CLI authenticated as: $(gh api user -q .login)"

# ── 3. Create skills directory ───────────────────────────────────────────────
mkdir -p "$HOME/.claude/skills"
echo "✓ Skills directory ready"

SKILLS_DIR="$HOME/nsls-skills"
mkdir -p "$SKILLS_DIR"

# ── 4. Clone cs-ops-skills ───────────────────────────────────────────────────
if [ -d "$SKILLS_DIR/cs-ops/.git" ]; then
  echo "✓ CS Ops skills already installed — pulling latest updates"
  git -C "$SKILLS_DIR/cs-ops" pull --quiet
else
  echo "→ Downloading NSLS Customer Success skills..."
  gh repo clone thensls/cs-ops-skills "$SKILLS_DIR/cs-ops" -- --quiet
  echo "✓ CS Ops skills downloaded"
fi

ln -sfn "$SKILLS_DIR/cs-ops" "$HOME/.claude/skills/cs-ops"
echo "✓ CS Ops skills connected to Claude"

# ── 5. Clone google-ai-mode skill ────────────────────────────────────────────
if [ -d "$SKILLS_DIR/google-ai-mode/.git" ]; then
  echo "✓ Google AI Mode skill already installed — pulling latest"
  git -C "$SKILLS_DIR/google-ai-mode" pull --quiet
else
  echo "→ Downloading Google AI Mode skill..."
  gh repo clone thensls/google-ai-mode "$SKILLS_DIR/google-ai-mode" -- --quiet
  echo "✓ Google AI Mode downloaded"
fi

ln -sfn "$SKILLS_DIR/google-ai-mode" "$HOME/.claude/skills/google-ai-mode"
echo "✓ Google AI Mode connected to Claude"

# ── 6. Add Every marketplace ─────────────────────────────────────────────────
claude plugin marketplace add https://github.com/EveryInc/compound-engineering-plugin.git 2>/dev/null || true

# ── 7. Install plugins ────────────────────────────────────────────────────────
echo "→ Installing Claude plugins (this takes about a minute)..."

install_plugin() {
  local plugin="$1"
  local marketplace="${2:-claude-plugins-official}"
  claude plugin install "${plugin}@${marketplace}" --scope user 2>/dev/null || \
  claude plugin install "$plugin" --scope user 2>/dev/null || true
}

install_plugin "superpowers"
install_plugin "compound-engineering" "every-marketplace"
install_plugin "skill-creator"

echo "✓ Plugins installed"

# ── 8. Set up Google AI Mode dependencies ────────────────────────────────────
echo "→ Setting up Google AI Mode (installs browser automation)..."
if command -v python3 &>/dev/null; then
  python3 -m pip install -r "$SKILLS_DIR/google-ai-mode/requirements.txt" -q 2>/dev/null || true
  python3 "$SKILLS_DIR/google-ai-mode/scripts/setup_environment.py" 2>/dev/null || true
  echo "✓ Google AI Mode dependencies ready"
else
  echo "  Note: Python 3 not found — run setup_environment.py manually after installing Python"
fi

# ── 9. Done ───────────────────────────────────────────────────────────────────
echo ""
echo "============================================"
echo "  Setup complete! Claude is ready to use."
echo "============================================"
echo ""
echo "What's installed:"
echo "  • CS Ops skills        → ~/.claude/skills/cs-ops"
echo "  • Google AI Mode       → ~/.claude/skills/google-ai-mode"
echo "  • superpowers          → enhanced Claude capabilities"
echo "  • compound-engineering → writing, planning, brainstorming tools"
echo "  • skill-creator        → propose and improve skills"
echo ""
echo "Try opening Claude Code and asking:"
echo "  'Research [any topic]' — Claude will use Google AI Mode for current info"
echo ""
echo "To update skills anytime:"
echo "  git -C ~/nsls-skills/cs-ops pull"
echo "  git -C ~/nsls-skills/google-ai-mode pull"
echo ""
