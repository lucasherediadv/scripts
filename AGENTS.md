# Agent Instructions

This repository is a curated collection of personal shell scripts designed to automate system management, enhance developer productivity, and streamline git workflows.

## General

Automatically update this `AGENTS.md` file when new preferences, conventions, or context are established for this repository

## Project Overview

- **Purpose:** A "Swiss Army Knife" of CLI utilities for daily development and OS maintenance.
- **Core Technologies:** Primarily `bash`, `perl` and `POSIX` compliant shell scripts.

## Development Conventions

- **Language:** Prefer `bash` for complex logic and `sh` for simple, portable scripts.
- **Location:** All executable scripts MUST reside in the `bin/` directory.
- **Formatting:** Scripts should follow standard shell scripting best practices (e.g., using `set -e` where appropriate, quoting variables).
- **Self-Documentation:** The `README.md` serves as the primary registry for all scripts. When adding a new script, ensure it is documented there.

## Commit Conventions

This repository follows [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` — A new feature or script
- `fix:` — A bug fix
- `chore:` — Maintenance, refactoring, or tooling changes
- `docs:` — Documentation-only changes (README, AGENTS, etc.)
- `style:` — Formatting changes only

Commit messages should be concise and written in the imperative mood (e.g., "add script" not "added script" or "adds script").
