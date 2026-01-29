# Upstream Synchronization System

This system automatically tracks and integrates updates from upstream projects that Goliath depends on.

## Quick Start

View the complete documentation in this directory:

- **README.md** - Overview and how it works (you are here)
- **SETUP.md** - Setup guide for new integrations
- **TROUBLESHOOTING.md** - Common issues and solutions

## Tracked Projects

1. **Darling** (macOS) - `libs/darling_framework/`
2. **ATL** (Android) - `libs/atl_android/`
3. **WSL** (Linux/Windows hybrid) - `libs/wsl/`
4. **Libretro** (Console emulation) - `libs/libretro/`
5. **ipasim** (iOS) - `libs/ipasim/`

## Automatic Updates

The workflow runs **weekly** and creates PRs when upstream projects have new commits.

## Manual Trigger

```bash
gh workflow run upstream-sync.yml
# Or for specific project:
gh workflow run upstream-sync.yml -f project=darling
```

See individual README files in this directory for detailed documentation.
