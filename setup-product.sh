#!/usr/bin/env bash
# NSLS Product — Claude Code setup script
# Run this once on a new machine after installing Claude Code and GitHub CLI.
# Usage: bash setup-product.sh

set -e

echo ""
echo "=== NSLS Product — Claude Setup ==="
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

# ── 4. Clone product-ops-skills ──────────────────────────────────────────────
if [ -d "$SKILLS_DIR/product-ops/.git" ]; then
  echo "✓ Product Ops skills already installed — pulling latest updates"
  git -C "$SKILLS_DIR/product-ops" pull --quiet
else
  echo "→ Downloading NSLS Product skills..."
  gh repo clone thensls/product-ops-skills "$SKILLS_DIR/product-ops" -- --quiet
  echo "✓ Product skills downloaded"
fi

ln -sfn "$SKILLS_DIR/product-ops" "$HOME/.claude/skills/product-ops"
echo "✓ Product skills connected to Claude"

# ── 5. Add Every marketplace ─────────────────────────────────────────────────
claude plugin marketplace add https://github.com/EveryInc/compound-engineering-plugin.git 2>/dev/null || true

# ── 6. Install plugins ────────────────────────────────────────────────────────
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

# ── 7. Done ───────────────────────────────────────────────────────────────────
echo ""
echo "============================================"
echo "  Setup complete! Claude is ready to use."
echo "============================================"
echo ""
echo "What's installed:"
echo "  • Product Ops skills   → ~/.claude/skills/product-ops"
echo "  • CS Tech Triage bot   → ~/.claude/skills/product-ops/cs-tech-triage"
echo "  • superpowers          → enhanced Claude capabilities"
echo "  • compound-engineering → writing, planning, brainstorming tools"
echo "  • skill-creator        → propose and improve skills"
echo ""
echo "To update skills anytime:"
echo "  git -C ~/nsls-skills/product-ops pull"
echo ""
