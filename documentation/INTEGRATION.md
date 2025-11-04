# Goliath Integration Guide

This guide explains how to integrate additional compatibility layers into Goliath.

## Overview

Goliath uses a modular architecture where each compatibility layer (Darling, ATL, WSL, Libretro, ipasim) is integrated as an optional component in the `libs/` directory.

## Integration Steps

### 1. Create Library Directory

Create a new directory in `libs/` for your component:

```bash
mkdir libs/mycomponent
```

### 2. Add Source Files

Add your component's source files to the directory. For example:

```
libs/mycomponent/
├── Makefile.in         # Build instructions
├── mycomponent.c       # Main implementation
├── mycomponent.h       # Public headers
└── README.md          # Component documentation
```

### 3. Create Makefile.in

Create a `Makefile.in` file following Wine's conventions:

```makefile
# mycomponent Makefile.in
STATICLIB = libmycomponent.a

SOURCES = \
    mycomponent.c \
    helper.c

# Or for a shared library
# MODULE = mycomponent.dll
# IMPORTS = kernel32
```

### 4. Register in configure.ac

Add your component to `configure.ac`:

```autoconf
# Near line 1320, add:
WINE_CONFIG_MAKEFILE(libs/mycomponent)
```

### 5. Add Configuration Options (Optional)

Add build options for your component in `configure.ac`:

```autoconf
AC_ARG_ENABLE(mycomponent,
    AS_HELP_STRING([--enable-mycomponent], [Enable MyComponent support]))

if test "x$enable_mycomponent" = "xyes"
then
    AC_DEFINE([HAVE_MYCOMPONENT], [1], [Define if MyComponent is enabled])
fi
```

### 6. Update Launcher Script

Update `goliath-launch.sh` to detect and handle your component's application format:

```bash
# Add detection logic
elif [[ "$filetype" == *"MyFormat"* ]]; then
    # MyComponent application
    exec mycomponent "$APP" "$@"
```

### 7. Add Documentation

Create documentation for your component:

```
documentation/
└── README-mycomponent.md
```

### 8. Regenerate Build System

After making changes, regenerate the build system:

```bash
./autogen.sh
./configure
make
```

## Integration Examples

### Example 1: Simple Static Library

For a simple static library that provides helper functions:

**libs/myhelper/Makefile.in:**
```makefile
STATICLIB = libmyhelper.a

SOURCES = \
    helper1.c \
    helper2.c
```

**libs/myhelper/helper1.c:**
```c
#include "helper.h"

void myhelper_init(void)
{
    // Initialization code
}
```

### Example 2: Compatibility Layer with Loaders

For a compatibility layer that loads binaries:

**libs/mycompat/Makefile.in:**
```makefile
STATICLIB = libmycompat.a

SOURCES = \
    loader.c \
    syscall.c \
    process.c \
    memory.c
```

**libs/mycompat/loader.c:**
```c
#include "wine/port.h"
#include "mycompat.h"

int mycompat_load_binary(const char *path)
{
    // Binary loading logic
    return 0;
}
```

## Best Practices

### 1. Naming Conventions

- Library names: `lib<component>.a` or `<component>.dll`
- Source files: Use descriptive names
- Headers: Place public headers in `include/<component>/`

### 2. Dependencies

Declare dependencies explicitly:

```makefile
IMPORTS = kernel32 ntdll user32
```

### 3. Error Handling

Use Wine's error handling conventions:

```c
#include "wine/debug.h"

WINE_DEFAULT_DEBUG_CHANNEL(mycomponent);

void myfunction(void)
{
    TRACE("Called myfunction\n");
    if (error)
        ERR("Error occurred: %s\n", error_message);
}
```

### 4. Testing

Add tests in a `tests/` subdirectory:

```
libs/mycomponent/
├── tests/
│   ├── Makefile.in
│   └── test_mycomponent.c
```

### 5. Platform Support

Consider platform-specific code:

```c
#ifdef __linux__
    // Linux-specific code
#elif defined(__APPLE__)
    // macOS-specific code
#endif
```

## Integration Checklist

- [ ] Create library directory
- [ ] Add source files
- [ ] Create Makefile.in
- [ ] Register in configure.ac
- [ ] Add configuration options (if needed)
- [ ] Update launcher script
- [ ] Add documentation
- [ ] Add tests
- [ ] Test build
- [ ] Test functionality

## Troubleshooting

### Build Errors

1. **"No rule to make target"**: Check that Makefile.in exists and is registered in configure.ac
2. **Undefined references**: Add missing libraries to IMPORTS
3. **Header not found**: Ensure headers are in include/ or use -I flags

### Runtime Errors

1. **Library not loaded**: Check that the library is built and installed
2. **Symbol not found**: Verify that functions are properly exported
3. **Segmentation fault**: Use debugging tools (gdb, valgrind)

## Advanced Topics

### Shared Code with Wine

To share code with Wine's infrastructure:

```c
#include "wine/library.h"
#include "wine/unicode.h"
#include "ntdll_misc.h"
```

### Cross-Layer Communication

For components that need to interact:

```c
// In include/goliath/ipc.h
struct goliath_ipc_message {
    int source_layer;
    int dest_layer;
    void *data;
    size_t size;
};
```

### Platform Detection

Use autoconf to detect platform capabilities:

```autoconf
AC_CHECK_HEADERS([myheader.h])
AC_CHECK_FUNCS([myfunction])
AC_CHECK_LIB([mylib], [myfunction])
```

## Resources

- Wine Developer Guide: https://wiki.winehq.org/Developer_Guide
- Wine Build System: https://source.winehq.org/git/wine.git/
- Goliath Architecture: See ARCHITECTURE.md

## Getting Help

- Goliath Issues: https://github.com/charlieduzstuf/Goliath/issues
- Wine Forums: https://forum.winehq.org/
- IRC: #WineHQ on libera.chat
