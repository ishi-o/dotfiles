---
name: claude-compat
description: Read CLAUDE.md and load .claude/* as skills from project root if they exist. Use when starting work in any project to load Claude-compatible configuration and skills.
metadata:
  short-description: Load CLAUDE.md and .claude/* skills
---

# Claude Compatibility

This skill loads Claude-compatible configuration and skills from the project root.

## Files Loaded

When working in a project, check for and read these files if they exist:

1. **CLAUDE.md** - Project-level instructions (equivalent to AGENTS.md)
2. **.claude/\*** - All files in this directory are treated as skills

## Behavior

### CLAUDE.md
- Treat as project-level instructions, same priority as AGENTS.md
- Read and apply all instructions within

### .claude/* Directory
- Each file in `.claude/` is a separate skill
- Read the description/metadata from each file to understand when to use it
- Apply skill instructions when the skill's trigger conditions are met

## Usage

Before starting work in any project:

1. Check if `<project-root>/CLAUDE.md` exists and read it as instructions
2. Check if `<project-root>/.claude/` directory exists
3. If .claude/ exists, enumerate all files within it
4. Read each file as a separate skill, extracting its purpose and instructions
5. Apply skills when their trigger conditions match the current task
