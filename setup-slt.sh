#!/usr/bin/env bash
# NSLS SLT Ops — Claude Code setup script
# Run this once on a new machine after installing Claude Code.
# Usage: bash setup-slt.sh

set -e

echo ""
echo "=== NSLS SLT Ops — Claude Setup ==="
echo ""

# ── 1. Check Claude Code is installed ────────────────────────────────────────
if ! command -v claude &>/dev/null; then
  echo "ERROR: Claude Code is not installed."
  echo "Install it from: https://claude.ai/download"
  exit 1
fi
echo "✓ Claude Code found: $(claude --version 2>/dev/null | head -1)"

# ── 2. Create skills directory ───────────────────────────────────────────────
mkdir -p "$HOME/.claude/skills"
echo "✓ Skills directory ready"

# ── 3. Clone slt-ops-skills ──────────────────────────────────────────────────
SKILLS_DIR="$HOME/nsls-skills"
mkdir -p "$SKILLS_DIR"

if [ -d "$SKILLS_DIR/slt-ops/.git" ]; then
  echo "✓ slt-ops-skills already cloned — pulling latest"
  git -C "$SKILLS_DIR/slt-ops" pull --quiet
else
  echo "→ Cloning thensls/slt-ops-skills..."
  git clone https://github.com/thensls/slt-ops-skills.git "$SKILLS_DIR/slt-ops"
  echo "✓ Cloned"
fi

# ── 4. Create symlink so Claude discovers the skills ─────────────────────────
ln -sfn "$SKILLS_DIR/slt-ops" "$HOME/.claude/skills/slt-operations"
echo "✓ Symlink created: ~/.claude/skills/slt-operations → $SKILLS_DIR/slt-ops"

# ── 5. Add Every marketplace ─────────────────────────────────────────────────
echo "→ Adding Every marketplace..."
claude plugin marketplace add https://github.com/EveryInc/compound-engineering-plugin.git 2>/dev/null || true
echo "✓ Every marketplace ready"

# ── 6. Install plugins ────────────────────────────────────────────────────────
echo "→ Installing plugins (this may take a minute)..."

install_plugin() {
  local plugin="$1"
  local marketplace="${2:-claude-plugins-official}"
  echo "  • $plugin"
  claude plugin install "${plugin}@${marketplace}" --scope user 2>/dev/null || \
  claude plugin install "$plugin" --scope user 2>/dev/null || true
}

install_plugin "superpowers"
install_plugin "compound-engineering" "every-marketplace"
install_plugin "skill-creator"
install_plugin "commit-commands"
install_plugin "slack"

echo "✓ Plugins installed"

# ── 7. Done ───────────────────────────────────────────────────────────────────
echo ""
echo "=== Setup complete! ==="
echo ""
echo "What's installed:"
echo "  • SLT Ops skills       → ~/.claude/skills/slt-operations"
echo "  • superpowers          → enhanced Claude capabilities"
echo "  • compound-engineering → writing, planning, brainstorming tools"
echo "  • skill-creator        → propose and build skill improvements"
echo "  • commit-commands      → git workflow helpers"
echo "  • slack                → Slack integration"
echo ""
echo "To update skills anytime:"
echo "  git -C ~/nsls-skills/slt-ops pull"
echo ""
echo "To propose a skill change, visit:"
echo "  https://github.com/thensls/slt-ops-skills"
echo ""
