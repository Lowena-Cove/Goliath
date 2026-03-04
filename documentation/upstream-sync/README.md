# Upstream Synchronization

This directory contains documentation for how Goliath tracks and integrates
updates from upstream projects.

## Tracked Projects

Goliath integrates code from the following upstream projects:

1. Wine (Windows app compatibility - primary foundation)
   - Repository: https://gitlab.winehq.org/wine/wine
   - Integration path: upstream/wine/
   - Auto-sync: Monthly

2. Darling (macOS/Darwin compatibility)
   - Repository: https://github.com/darlinghq/darling
   - Integration path: upstream/darlin-upstream/
   - Auto-sync: Monthly

3. ATL (Android Translation Layer)
   - Repository: https://gitlab.com/android_translation_layer/android_translation_layer
   - Integration path: upstream/atl-upstream/
   - Auto-sync: Monthly

4. WSL (Windows Subsystem for Linux concepts)
   - Repository: https://github.com/microsoft/WSL
   - Integration path: upstream/wsl-upstream/
   - Auto-sync: Monthly

5. Libretro (Console emulation common library)
   - Repository: https://github.com/libretro/libretro-common
   - Integration path: upstream/libretro-upstream/
   - Auto-sync: Monthly

6. ipasim (iOS simulation)
   - Repository: https://github.com/ipasimulator/ipasim
   - Integration path: libs/ipasim/
   - Auto-sync: Monthly

## Platform Exclusion Matrix

| Layer    | Linux | Windows | macOS | Notes |
|----------|:-----:|:-------:|:-----:|-------|
| Wine     | ✅    | ❌      | ✅    | Wine runs Windows apps on Unix; redundant on Windows itself |
| Darling  | ❌    | ❌      | ✅    | macOS/Darwin compatibility layer |
| WSL      | ✅    | ❌      | ❌    | Linux-specific WSL concepts |
| Libretro | ✅    | ✅      | ✅    | Cross-platform; always included |
| ipasim   | ❌    | ❌      | ✅    | iOS simulation (requires macOS/Darwin) |
| ATL      | ✅    | ❌      | ❌    | Android Translation Layer for Linux |

## How It Works

The upstream-sync.yml workflow automatically:

1. Checks each upstream repository monthly
2. Compares the latest upstream commit with our integrated version
3. Creates a PR when updates are available
4. Tracks version information in .upstream_version files
5. Documents changes in UPSTREAM_SYNC.md files

## Manual Sync

Run: gh workflow run upstream-sync.yml -f project=wine
Run: gh workflow run upstream-sync.yml -f project=all

## Version Tracking

Each library directory contains:

- .upstream_version - The current upstream commit hash
- .upstream_repo - The upstream repository path
- .last_sync - Timestamp of last successful sync
- UPSTREAM_SYNC.md - Human-readable sync report
