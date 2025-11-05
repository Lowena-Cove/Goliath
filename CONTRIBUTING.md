# Contributing to Goliath

Thank you for your interest in contributing to Goliath! This document provides guidelines for contributing to the project.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Integration Guidelines](#integration-guidelines)
- [Coding Standards](#coding-standards)
- [Testing](#testing)
- [Documentation](#documentation)
- [Submitting Changes](#submitting-changes)

## Code of Conduct

We follow the Wine project's code of conduct. Please be respectful and professional in all interactions.

## Getting Started

### Prerequisites

1. Fork the repository on GitHub
2. Clone your fork:
   ```bash
   git clone https://github.com/yourusername/Goliath.git
   cd Goliath
   ```

3. Set up upstream remote:
   ```bash
   git remote add upstream https://github.com/charlieduzstuf/Goliath.git
   ```

4. Install development dependencies:
   ```bash
   # Debian/Ubuntu
   sudo apt-get install build-essential autoconf automake libtool \
                        flex bison libx11-dev git

   # Fedora/RHEL
   sudo dnf install gcc make autoconf automake libtool flex bison \
                    libX11-devel git
   ```

### Building for Development

```bash
./autogen.sh
./configure --enable-darling --enable-atl
make
```

## Development Workflow

### Branch Strategy

- `main`: Stable releases
- `develop`: Development branch
- `feature/*`: New features
- `bugfix/*`: Bug fixes

### Creating a Feature Branch

```bash
git checkout -b feature/my-new-feature develop
```

### Keeping Your Branch Updated

```bash
git fetch upstream
git rebase upstream/develop
```

## Integration Guidelines

### Adding a New Compatibility Layer

See [INTEGRATION.md](INTEGRATION.md) for detailed instructions.

Quick checklist:
1. Create `libs/component/` directory
2. Add source files
3. Create `Makefile.in`
4. Register in `configure.ac`
5. Update launcher script
6. Add documentation
7. Write tests

### Modifying Existing Components

1. Wine core changes:
   - Follow Wine's coding style
   - Test with Wine's test suite
   - Consider upstream compatibility

2. Goliath-specific changes:
   - Maintain modularity
   - Document integration points
   - Test cross-component interactions

## Coding Standards

### C Code Style

Follow Wine's coding conventions:

```c
/* Use Wine-style comments for file headers */
/*
 * Component Name
 *
 * Copyright (C) 2025 Your Name
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 */

#include "wine/port.h"
#include <stdio.h>

#include "windef.h"
#include "winbase.h"

/* Function comments */
void my_function(int param)
{
    /* Use braces even for single-line blocks */
    if (param > 0)
    {
        do_something();
    }
}
```

### Naming Conventions

- Functions: `component_function_name()` (lowercase with underscores)
- Structures: `struct component_struct` (lowercase with underscores)
- Constants: `COMPONENT_CONSTANT` (uppercase with underscores)
- Macros: `COMPONENT_MACRO()` (uppercase with underscores)

### Header Files

```c
#ifndef __GOLIATH_COMPONENT_H
#define __GOLIATH_COMPONENT_H

/* Public API */
extern void component_init(void);
extern int component_process(void *data);

#endif /* __GOLIATH_COMPONENT_H */
```

### Error Handling

Use Wine's debug channels:

```c
#include "wine/debug.h"

WINE_DEFAULT_DEBUG_CHANNEL(component);

void my_function(void)
{
    TRACE("Entering my_function\n");
    
    if (error_condition)
    {
        ERR("Error: %s\n", error_message);
        return;
    }
    
    WARN("Warning: %s\n", warning_message);
}
```

Debug levels:
- `TRACE()`: Verbose debugging information
- `WARN()`: Warnings
- `ERR()`: Errors
- `FIXME()`: Not yet implemented

### Shell Scripts

For bash scripts like `goliath-launch.sh`:

```bash
#!/usr/bin/env bash
# Brief description
#
# Detailed description if needed

set -e  # Exit on error

# Use descriptive variable names
readonly PROGRAM_NAME="$(basename "$0")"
readonly PROGRAM_VERSION="1.0"

# Function naming: lowercase with underscores
show_help() {
    cat << EOF
Usage: $PROGRAM_NAME [OPTIONS] <file>
Description
EOF
}

# Main logic
main() {
    # Implementation
}

main "$@"
```

## Testing

### Unit Tests

Add tests in `libs/component/tests/`:

```c
#include "wine/test.h"
#include "component.h"

START_TEST(component)
{
    /* Test cases */
    ok(component_init() == 0, "Initialization failed\n");
    ok(component_process(NULL) == -1, "Should fail with NULL\n");
}
```

### Running Tests

```bash
# Run all tests
make test

# Run specific component tests
make -C libs/component/tests test
```

### Integration Tests

Test cross-component functionality:

```bash
# Test launcher with different file types
./goliath-launch.sh tests/sample.exe
./goliath-launch.sh tests/sample.app
```

### Manual Testing

Before submitting:
1. Build from clean state
2. Test basic functionality
3. Test error conditions
4. Test on different platforms (if possible)

## Documentation

### Code Documentation

- Document all public APIs
- Include usage examples
- Document return values and error conditions
- Use Doxygen-style comments for complex functions

### User Documentation

Update relevant documentation:
- `README.md`: Main project readme
- `documentation/README-goliath.md`: User guide
- `documentation/ARCHITECTURE.md`: Architecture details
- `documentation/INTEGRATION.md`: Integration guide

### Commit Messages

Follow this format:

```
component: Brief summary (50 chars or less)

More detailed explanation if needed. Wrap at 72 characters.
Explain what changed and why.

- Bullet points for multiple changes
- Reference issues: Fixes #123
```

Examples:
```
darling: Add Mach-O binary loader

Implements basic Mach-O loading functionality including:
- Binary parsing
- Symbol resolution
- Dylib loading

Related to #45
```

## Submitting Changes

### Before Submitting

1. **Update your branch**:
   ```bash
   git fetch upstream
   git rebase upstream/develop
   ```

2. **Build and test**:
   ```bash
   ./autogen.sh
   ./configure
   make
   make test
   ```

3. **Run linter** (if available):
   ```bash
   # Check code style
   ./tools/check-style.sh
   ```

4. **Update documentation**

5. **Commit your changes**:
   ```bash
   git add -A
   git commit -m "component: Description"
   ```

### Creating a Pull Request

1. Push to your fork:
   ```bash
   git push origin feature/my-new-feature
   ```

2. Go to GitHub and create a Pull Request

3. PR Description should include:
   - What changed
   - Why it changed
   - How to test
   - Related issues

Example PR template:
```markdown
## Description
Brief description of changes

## Motivation
Why this change is needed

## Changes
- List of changes
- Another change

## Testing
How to test these changes

## Checklist
- [ ] Code follows style guidelines
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] All tests pass
- [ ] No new warnings

Fixes #123
```

### Code Review Process

1. Maintainers will review your PR
2. Address any feedback
3. Update your PR:
   ```bash
   # Make changes
   git add -A
   git commit --amend
   git push --force origin feature/my-new-feature
   ```

4. Once approved, your PR will be merged

## Component-Specific Guidelines

### Wine Core

- Maintain Wine compatibility
- Consider upstreaming changes to Wine
- Follow Wine patch submission guidelines

### Darling Integration

- Respect Darling's GPL license
- Keep Darling code isolated in `libs/darling/`
- Document macOS framework mappings

### ATL Integration

- Follow ATL's Apache license
- Keep Android-specific code in `libs/atl_android/`
- Document Android API implementations

### New Components

- Start with a proposal/discussion
- Create a design document
- Implement in phases
- Add comprehensive tests

## Getting Help

- **Issues**: https://github.com/charlieduzstuf/Goliath/issues
- **Discussions**: https://github.com/charlieduzstuf/Goliath/discussions
- **Wine IRC**: #WineHQ on libera.chat

## License

By contributing to Goliath, you agree that your contributions will be licensed under the same license as the component you're contributing to:
- Wine core: LGPL 2.1+
- Darling integration: GPL 3.0
- ATL integration: Apache 2.0

See LICENSE files for details.

## Recognition

Contributors are recognized in:
- Git commit history
- AUTHORS file
- Release notes

Thank you for contributing to Goliath!
