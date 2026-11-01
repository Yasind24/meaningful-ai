# meaningful-ai

Practical AI tools I build in the open, for anyone who works with AI.

"Meaningful" is the bar for what goes in here: each tool should make a real decision or task better, keep a human in charge of the judgement, and be honest about what it does not know. No demos for their own sake.

It starts with Claude agent skills. More skills and small tools will follow.

## Claude skills

| Skill | What it does |
| --- | --- |
| [honest-resume](Claude%20skills/honest-resume/) | Decides whether a job is worth applying to, then builds a tailored, ATS-safe resume from your verified facts only. Nothing invented. |
| stress-test | Red-teams an idea, plan or strategy: the core assumption, failure modes, blind spots, the strongest argument against it, and a verdict. |

## Install a skill

- **Claude apps:** upload a `.skill` file from [Claude skills](Claude%20skills/) under Settings → Capabilities → Skills.
- **Claude Code:** copy a skill folder into `~/.claude/skills/` (all projects) or `.claude/skills/` in one project.

## About

Built by [Mohamed Yasin](https://github.com/Yasind24). Suggestions and issues are welcome.
