# honest-resume

A Claude skill that tells you whether a job is worth applying to, and then builds a polished, ATS-safe resume for it, using only facts you have verified about yourself.

## Why

Two kinds of tailored resume tend to fail:
- **Generic ones:** nobody reads them.
- **Stretched ones:** keyword-stuffed with tools you have barely touched, team sizes rounded up, and projections presented as results. Interviewers find these out.

This skill does neither. The job description changes what is **emphasised**. It never changes what is **true**. And if a role is a poor fit, the skill says so instead of producing a resume that will be rejected.

## What it does

1. **Reads the job:** from a link, pasted text, or the page open in your browser.
2. **Runs a fit check:** hard gates (location, pay floor, seniority, core skills), then a score out of 12. The result is **Apply**, **Apply as a stretch** (with the gaps named), or **Skip**.
3. **Builds the resume:** a clean single-column HTML design, rendered to PDF, written only from your facts file.
4. **Audits every claim:** each line is linked to the fact behind it, with notes for the claims interviewers are likely to probe.

## Your data stays yours

The skill holds no personal data. On first use it sets up two files in your own folder:

- `career/career-facts.md`: every usable fact, tagged `OK`, `PRIVATE`, `CONFIRM` or `NEVER`, so old resume claims you would not defend never come back.
- `career/preferences.md`: target roles, location rules, pay floor, and anything you never want employers to see.

Each application gets its own folder: `career/applications/<date> <Company> - <Role>/`, with `fit-report.md`, `resume.html`, the PDF and `claims.md`.

## Install

- **Claude Code:** copy the `honest-resume` folder to `~/.claude/skills/` (for all projects) or to `.claude/skills/` in your job-search folder.
- **Claude apps:** upload `honest-resume.skill` under Settings → Capabilities → Skills.

PDF rendering needs Google Chrome, Chromium or Microsoft Edge. The text check uses `pypdf`, `pdftotext`, or Swift on macOS, whichever is available. Without a browser, open `resume.html` and use Print → Save as PDF.

## Use

> Set up my career facts from my resume and LinkedIn

> Should I apply to this? https://example.com/jobs/123

> Make me a resume for the job open in my browser

## Principles

- Nothing is invented. If a job asks for something you have not done, it appears as a gap in the fit report, not as a bullet on the resume.
- Your real titles only. The headline can position you; it never promotes you.
- A "Skip" is a good outcome. Fewer, better-matched applications beat volume.
- The skill never submits applications, sends email or fills in forms unless you ask.
