# Setup First - Claude Code Configuration Scripts

This directory contains scripts to configure and install Everything Claude Code (ECC) components.

## Quick Start

### One-Click Installation

```cmd
install-ecc.bat
```

This will:
1. **Install all plugins** (Rules, Agents, Commands, Skills)
2. **Configure debug display** (optional, asked during install)
3. **Create backups** of existing configuration

---

## Scripts Overview

| Script | Description |
|--------|-------------|
| `install-ecc.bat` | **Main installer** - Install all components + debug config |
| `uninstall-ecc.bat` | Remove all ECC components |
| `setup-debug-config.bat` | Configure debug display only (standalone) |
| `uninstall-debug-config.bat` | Remove debug config only (standalone) |

---

## Installation Flow

```
┌─────────────────────────────────────────────────────────────┐
│                   install-ecc.bat                           │
├─────────────────────────────────────────────────────────────┤
│  1. Check if already installed → Prompt to reinstall        │
│  2. Select language rules (All/TypeScript/Python/Go/Swift)  │
│  3. Ask to enable debug display                             │
│  4. Create directories                                       │
│  5. Backup existing files                                    │
│  6. Install Rules (common + language-specific)              │
│  7. Install Agents (13 subagents)                           │
│  8. Install Commands (32 slash commands)                    │
│  9. Install Skills (48 skills)                              │
│  10. Install Hook Scripts                                    │
│  11. Configure debug display (if enabled)                   │
│  12. Create installation marker                              │
└─────────────────────────────────────────────────────────────┘
```

---

## Installation Options

### Language Selection

When running `install-ecc.bat`, choose which language rules to install:

| Option | Languages |
|--------|-----------|
| 1 | All languages (recommended) |
| 2 | TypeScript only |
| 3 | Python only |
| 4 | Go only |
| 5 | Swift only |
| 6 | Custom selection |

### Debug Display

When enabled, Claude Code will show:
- `[Skill: name]` when a skill is activated
- `[Rule: name]` when a rule is being followed
- `[Agent: name]` when delegating to a subagent
- `[Hook: type]` when a hook fires

---

## Installed Components

| Component | Count | Path |
|-----------|-------|------|
| Rules (common) | 9 files | `~/.claude/rules/common/` |
| Rules (language) | 5×N files | `~/.claude/rules/{lang}/` |
| Agents | 13 | `~/.claude/agents/` |
| Commands | 32 | `~/.claude/commands/` |
| Skills | 48 | `~/.claude/skills/` |
| Scripts | Multiple | `~/.claude/scripts/` |

---

## After Installation

### Restart Claude Code

```cmd
# Close all Claude Code windows
# Then restart
claude
```

### Verify Installation

```
/agents          # List available agents
/plan "feature"  # Test planner agent
/tdd             # Test TDD workflow
```

### Available Commands

| Command | Description |
|---------|-------------|
| `/plan` | Create implementation plan |
| `/tdd` | Test-driven development workflow |
| `/code-review` | Code quality review |
| `/build-fix` | Fix build errors |
| `/security-scan` | Security vulnerability scan |
| `/go-review` | Go code review |
| `/python-review` | Python code review |
| `/test-coverage` | Test coverage analysis |
| `/orchestrate` | Multi-agent orchestration |
| `/learn` | Extract patterns from session |

---

## Safety Features

| Feature | Description |
|---------|-------------|
| **Idempotent** | Running multiple times won't corrupt files |
| **Auto-backup** | Existing files backed up before modification |
| **Marker files** | Prevents accidental reconfiguration |
| **Reversible** | Use uninstall scripts to remove cleanly |
| **Interactive** | Choose what to install |

---

## Directory Structure After Installation

```
~/.claude/
├── rules/
│   ├── common/           # Language-agnostic rules
│   ├── typescript/       # TypeScript-specific rules
│   ├── python/           # Python-specific rules
│   ├── golang/           # Go-specific rules
│   └── swift/            # Swift-specific rules
├── agents/               # 13 subagent definitions
├── commands/             # 32 slash commands
├── skills/               # 48 skill definitions
├── scripts/              # Hook scripts and utilities
│   ├── hooks/
│   └── lib/
├── backups/              # Automatic backups
├── settings.json         # Claude Code settings (with debug config)
├── .ecc-installed        # Installation marker
└── .ecc-debug-configured # Debug config marker
```

---

## Standalone Debug Configuration

If you only want to configure debug display without reinstalling:

```cmd
setup-debug-config.bat
```

To remove debug config only:

```cmd
uninstall-debug-config.bat
```

---

## Uninstallation

### Remove Everything

```cmd
uninstall-ecc.bat
```

This removes:
- All rules, agents, commands, skills
- Hook scripts
- Installation markers
- Debug configuration from settings.json

### Restore from Backup

```cmd
# List available backups
dir "%USERPROFILE%\.claude\backups"

# Restore a backup
xcopy "%USERPROFILE%\.claude\backups\pre_uninstall_YYYYMMDD_HHMMSS\*" "%USERPROFILE%\.claude\" /E /I /Q
```

---

## Troubleshooting

### Installation fails

1. Ensure you have write permissions to `%USERPROFILE%\.claude`
2. Close Claude Code before installing
3. Run as Administrator if needed

### Commands not found after install

1. Restart Claude Code completely
2. Check files exist in `%USERPROFILE%\.claude\commands\`
3. Verify file extensions are `.md`

### Debug display not working

1. Check `settings.json` contains `appendSystemPrompt`
2. Restart Claude Code
3. Run `setup-debug-config.bat` to reconfigure

---

## Cross-Platform

For macOS/Linux, use the shell scripts in the root directory:

```bash
./install.sh typescript python golang
```

---

## Files in This Directory

```
setup_first/
├── README.md                    # This documentation
├── install-ecc.bat              # Main installer (all-in-one)
├── uninstall-ecc.bat            # Remove all components
├── setup-debug-config.bat       # Debug config only (standalone)
└── uninstall-debug-config.bat   # Remove debug config only
```
