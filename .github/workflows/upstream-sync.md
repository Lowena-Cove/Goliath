---
on:
  schedule:
    - cron: '0 1 1 * *'
  workflow_dispatch:
    inputs:
      project:
        description: 'Specific project to sync (all, wine, darling, atl, wsl, libretro, ipasim)'
        required: false
        default: 'all'
permissions:
  contents: read
  pull-requests: read
safe-outputs:
  create-pull-request:
  create-issue:
tools:
  web-fetch:
---

# Upstream Dependency Sync Agent

You are a dependency management agent for the **Goliath** project. Goliath
integrates code from six upstream open-source projects. Your job is to check
each upstream repository for new commits, compare them against our tracked
version, and create pull requests when updates are available.

## Tracked upstream projects

| Name | Repository | Integration path | Branch | Host |
|------|-----------|-----------------|--------|------|
| Wine | wine/wine | upstream/wine | master | gitlab.winehq.org |
| Darling | darlinghq/darling | upstream/darlin-upstream | master | github.com |
| ATL | android_translation_layer/android_translation_layer | upstream/atl-upstream | main | gitlab.com |
| WSL | microsoft/WSL | upstream/wsl-upstream | master | github.com |
| Libretro | libretro/libretro-common | upstream/libretro-upstream | master | github.com |
| ipasim | ipasimulator/ipasim | libs/ipasim | master | github.com |

## Platform exclusion matrix

| Layer | Linux | Windows | macOS |
|-------|:-----:|:-------:|:-----:|
| Wine | ✅ | ❌ | ✅ |
| Darling | ❌ | ❌ | ✅ |
| WSL | ✅ | ❌ | ❌ |
| Libretro | ✅ | ✅ | ✅ |
| ipasim | ❌ | ❌ | ✅ |
| ATL | ✅ | ❌ | ❌ |

## Instructions

For each project above:

1. Clone the upstream repository (shallow, depth 50).
2. Get the latest commit hash and message.
3. Read the current `.upstream_version` file in the integration path.
   Use only the first line (`head -1 | tr -d '\r'`).
4. If the version differs, create a new branch `upstream-sync/<name>-<short_hash>`.
5. Update the tracking files (`.upstream_version`, `.upstream_repo`, `.last_sync`,
   `UPSTREAM_SYNC.md`).
6. Force-push the branch (to handle reruns where the branch already exists).
7. Create a pull request with the sync details.

## Known issues to handle

- Some integration paths may have orphaned git submodule entries (mode 160000).
  Remove stale submodule entries with `git rm --cached` before writing files.
- Use `git diff --staged --quiet` to skip commits when nothing was staged.
- GitLab repos (Wine, ATL) need different clone URLs than GitHub repos.
- The `.upstream_version` file may contain multi-line content — always read
  only the first line.
