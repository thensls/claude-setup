# NSLS Claude Setup

One-command setup for NSLS team members using Claude Code.

---

## Before you start

You need **Claude Code** installed. Download it at [claude.ai/download](https://claude.ai/download) and sign in with your Anthropic account.

---

## Setup (pick your team)

Open Terminal and run the command for your team. It handles everything — cloning the skills, creating the right folders, and installing the plugins.

### People Operations (HR team)

```bash
bash <(curl -s https://raw.githubusercontent.com/thensls/claude-setup/main/setup-hr.sh)
```

**Installs:**
- People Ops skills (scorecards, check-ins, reviews, role management)
- `superpowers` — enhanced Claude capabilities
- `compound-engineering` — writing, planning, brainstorming tools
- `skill-creator` — propose improvements to the skills

### Senior Leadership Team

**New SLT member?** Start with the [SLT Onboarding Guide](onboarding-slt.md) — it covers the SLT Coach bot, goal updates, coaching, and Claude Code setup.

```bash
bash <(curl -s https://raw.githubusercontent.com/thensls/claude-setup/main/setup-slt.sh)
```

**Installs everything above, plus:**
- SLT Ops skills (meeting agendas, goal tracking, coaching)
- `commit-commands` — git workflow helpers
- `slack` — Slack integration

### Customer Success

```bash
bash <(curl -s https://raw.githubusercontent.com/thensls/claude-setup/main/setup-cs.sh)
```

**Installs:**
- CS Ops skills (as the team builds them out)
- Google AI Mode — AI-synthesized web research with source citations from 100+ sites
- `superpowers` — enhanced Claude capabilities
- `compound-engineering` — writing, planning, brainstorming tools
- `skill-creator` — propose improvements to the skills

### Marketing

```bash
bash <(curl -s https://raw.githubusercontent.com/thensls/claude-setup/main/setup-marketing.sh)
```

**Installs:**
- Marketing Ops skills (as the team builds them out)
- Google AI Mode — AI-synthesized web research with source citations from 100+ sites
- `superpowers` — enhanced Claude capabilities
- `compound-engineering` — writing, planning, brainstorming tools
- `skill-creator` — propose improvements to the skills

### Product

```bash
bash <(curl -s https://raw.githubusercontent.com/thensls/claude-setup/main/setup-product.sh)
```

**Installs:**
- Product Ops skills (CS tech triage bot, more coming)
- `superpowers` — enhanced Claude capabilities
- `compound-engineering` — writing, planning, brainstorming tools
- `skill-creator` — propose improvements to the skills

---

## Updating your skills

Skills improve over time. To pull the latest:

```bash
# HR team
git -C ~/nsls-skills/people-ops pull

# SLT team
git -C ~/nsls-skills/slt-ops pull

# CS team
git -C ~/nsls-skills/cs-ops pull
git -C ~/nsls-skills/google-ai-mode pull

# Marketing team
git -C ~/nsls-skills/marketing-ops pull
git -C ~/nsls-skills/google-ai-mode pull

# Product team
git -C ~/nsls-skills/product-ops pull
```

Or just re-run your setup script — it's safe to run again anytime.

---

## How skills work

When you open Claude Code, it automatically looks in `~/.claude/skills/` for skills to load. The setup script puts the NSLS skills there (via a symlink — a shortcut that points to where the actual files live).

When you open Claude and say something like "prepare the quarterly check-in for Sarah", Claude recognizes the task and uses the relevant skill automatically. You don't need to name the skill or remember any commands.

---

## Contributing to skills

Each skill set has its own GitHub repo with a guide for proposing changes:

- **HR skills**: [github.com/thensls/people-ops-skills](https://github.com/thensls/people-ops-skills) — see `CONTRIBUTING.md`
- **SLT skills**: [github.com/thensls/slt-ops-skills](https://github.com/thensls/slt-ops-skills) — see `CONTRIBUTING.md`
- **CS skills**: [github.com/thensls/cs-ops-skills](https://github.com/thensls/cs-ops-skills) — see `CONTRIBUTING.md`
- **Marketing skills**: [github.com/thensls/marketing-ops-skills](https://github.com/thensls/marketing-ops-skills) — see `CONTRIBUTING.md`
- **Product skills**: [github.com/thensls/product-ops-skills](https://github.com/thensls/product-ops-skills) — see `CONTRIBUTING.md`

The short version: click the pencil icon on any `SKILL.md` file in GitHub, make your edit, and submit it as a proposed change. Kevin reviews and approves.

---

## Questions?

Ping Kevin or leave a comment in the relevant GitHub repo.
