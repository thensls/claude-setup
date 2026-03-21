#!/usr/bin/env bash
# NSLS People Ops — Claude Code setup script
# Run this once on a new machine after installing Claude Code and GitHub CLI.
# Usage: bash setup-hr.sh

set -e

echo ""
echo "=== NSLS People Ops — Claude Setup ==="
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

# ── 4. Clone people-ops-skills ───────────────────────────────────────────────
SKILLS_DIR="$HOME/nsls-skills"
mkdir -p "$SKILLS_DIR"

if [ -d "$SKILLS_DIR/people-ops/.git" ]; then
  echo "✓ People Ops skills already installed — pulling latest updates"
  git -C "$SKILLS_DIR/people-ops" pull --quiet
else
  echo "→ Downloading NSLS People Ops skills..."
  gh repo clone thensls/people-ops-skills "$SKILLS_DIR/people-ops" -- --quiet
  echo "✓ Skills downloaded"
fi

# ── 4b. Clone nsls-coach bot ──────────────────────────────────────────────
if [ -d "$SKILLS_DIR/nsls-coach/.git" ]; then
  echo "✓ NSLS Coach bot already installed — pulling latest updates"
  git -C "$SKILLS_DIR/nsls-coach" pull --quiet
else
  echo "→ Downloading NSLS Coach bot code..."
  gh repo clone thensls/nsls-coach "$SKILLS_DIR/nsls-coach" -- --quiet
  echo "✓ Bot code downloaded"
fi

# ── 5. Create symlink so Claude discovers the skills ─────────────────────────
ln -sfn "$SKILLS_DIR/people-ops" "$HOME/.claude/skills/people-ops"
echo "✓ Skills connected to Claude"

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

# ── 8. Done ───────────────────────────────────────────────────────────────────
echo ""
echo "============================================"
echo "  Setup complete! Claude is ready to use."
echo "============================================"
echo ""
echo "Open Claude Code and try saying:"
echo "  'Prepare a quarterly check-in for [employee name]'"
echo "  'Help me build a scorecard for [role]'"
echo ""
echo "To get skill updates in the future, run:"
echo "  git -C ~/nsls-skills/people-ops pull"
echo ""
