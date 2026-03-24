# SLT Member Onboarding — Claude + SLT Coach Bot

Welcome to the NSLS AI tooling. This doc covers two things:

1. **SLT Coach Bot** — a Slack bot that handles meeting prep, goal tracking, and post-meeting coaching
2. **Claude Code** — an AI coding assistant with NSLS-specific skills (optional, for deeper use)

---

## Part 1: SLT Coach Bot (Slack)

The SLT Coach bot lives in your Slack DMs and in #nsls-leadership. You don't need to install anything — it's already running.

### What the bot does on autopilot

| When | What | Where |
|------|------|-------|
| Thursday 3 PM ET | Requests agenda topics for Tuesday's meeting | #nsls-leadership + your DMs |
| Thursday 9 AM ET (every other week) | L2 goal update check-in | Your DMs |
| Friday 11:30 AM ET | Drafts next week's agenda | Kevin review → #nsls-leadership |
| Monday 11:30 AM ET | Finalizes agenda + creates Google Doc | #nsls-leadership |
| After Tuesday meeting | Post-meeting coaching conversation | Your DMs (Wednesday) |

### L2 Goal Updates

Every other Thursday at 9 AM ET, the bot DMs you with your L2 goals one at a time. For each goal:
1. It shows the goal name, current status, and deadline
2. You reply with a brief status update (1-3 sentences is fine)
3. It asks for a health rating (On Track / At Risk / Off Track)
4. It moves to the next goal

**Timing**: You have 24 hours to complete your updates. If the session times out, type **goal** to restart.

**Quick tips**:
- You can respond whenever it's convenient — no need to do it the moment the DM arrives
- If you want to update goals outside the scheduled cycle, type **goal** to start a session anytime
- Updates are saved to Airtable and feed into the Monday weekly update and Tuesday's agenda

### Post-Meeting Coaching

After each Tuesday meeting, the bot analyzes the transcript and sends you a personalized coaching DM. This typically includes:
- How you contributed (speaking time, topics led)
- A "start" recommendation (something to try next meeting)
- A "stretch" challenge (something harder)
- An optional growth goal you can accept or skip

You can have a back-and-forth conversation with the bot about leadership, team dynamics, or anything on your mind. Type **done** to end the session.

### Agenda Topics

When the bot asks for agenda topics (Thursday), reply in the #nsls-leadership thread with:
- What decisions you need the group to make
- What you need real-time collaboration on
- Any blockers or risks the team should discuss

The bot categorizes your topic as Info Sharing, Value Creation, or Decision and maps it to the relevant L2 goals.

### Useful commands

| Type this in your DM with the bot | What happens |
|--------------------------------------|-------------|
| **goal** | Start a new L2 goal update session |
| **done** | End a coaching conversation |
| **explain** | Get a full explanation of the current process |
| **some coaching please** | Start an on-demand coaching session |

---

## Part 2: Claude Code (Optional)

Claude Code is an AI assistant that runs in your terminal. With the SLT skills installed, it can help you with meeting prep, goal analysis, and more. This is optional — the bot handles most things automatically.

### Quick install

1. **Download Claude Code**: [claude.ai/download](https://claude.ai/download) — sign in with your Anthropic account
2. **Install GitHub CLI**: [cli.github.com](https://cli.github.com) — then run `gh auth login`
3. **Run the setup script**:

```bash
bash <(curl -s https://raw.githubusercontent.com/thensls/claude-setup/main/setup-slt.sh)
```

This clones the SLT skills, installs plugins, and connects everything. Takes about 2 minutes.

### What you can do with Claude Code

Open your terminal, type `claude`, and try:
- "Prepare this week's SLT agenda"
- "What are my open action items?"
- "Summarize last week's meeting feedback"
- "Show me the L2 goals that are at risk"

### Updating

Skills improve over time. To get the latest:

```bash
git -C ~/nsls-skills/slt-ops pull
git -C ~/nsls-skills/slt-coach pull
```

Or just re-run the setup script — it's safe to run again anytime.

---

## Part 3: What to Expect This Week

Here's the typical weekly rhythm:

| Day | What happens |
|-----|-------------|
| **Thursday** | Bot requests agenda topics in #nsls-leadership. Reply in the thread. |
| **Thursday** (every other week) | Bot DMs you for L2 goal updates. Reply when convenient. |
| **Friday** | Bot drafts the agenda based on topics, goals, and action items. |
| **Monday** | Kevin finalizes the agenda. Google Doc link posted to #nsls-leadership. |
| **Tuesday** | Meeting. Fathom records and transcribes. |
| **Wednesday** | Bot sends you a coaching DM based on the meeting. |

---

## Questions?

Ping Kevin in Slack or reply to any bot DM with your question — the bot can handle most things, and Kevin gets notified if it can't.
