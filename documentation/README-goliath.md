# Goliath Unified Compatibility Layer

Goliath is a unified compatibility layer that extends Wine to support applications from multiple operating systems. Built on Wine's proven Windows compatibility infrastructure, Goliath integrates additional compatibility layers for macOS, Android, iOS, and console platforms.

## Vision

Create a single, unified platform that can build for every major OS and run applications from nearly every OS, eliminating the need for multiple separate compatibility tools.

## Supported Platforms

### Currently Implemented
- **Windows**: Full Wine compatibility for Windows applications (.exe, .dll)

### In Development
- **macOS**: Darling integration for macOS applications (.app, Mach-O binaries)
- **Android**: ATL (Android Translation Layer) for Android apps (.apk)

### Planned
- **iOS**: ipasim integration for iOS applications (.ipa)
- **Linux on Windows**: WSL-inspired compatibility concepts
- **Console Systems**: Libretro integration for game console emulation

## Architecture

Goliath follows a **modular architecture**:

```
┌─────────────────────────────────────┐
│      Goliath Unified Launcher       │
│        (goliath-launch.sh)          │
└──────────────┬──────────────────────┘
               │
       ┌───────┴───────┐
       │  App Detection │
       └───────┬────────┘
               │
    ┌──────────┴──────────┐
    │                     │
┌───▼────┐  ┌───────┐  ┌─▼─────┐
│  Wine  │  │Darling│  │  ATL  │ ...
└────────┘  └───────┘  └───────┘
     │          │          │
     └──────────┴──────────┘
              │
     ┌────────▼─────────┐
     │ Shared Goliath   │
     │  Infrastructure  │
     └──────────────────┘
```

Each compatibility layer is:
- **Optional**: Enable only what you need
- **Isolated**: Maintains its own codebase
- **Integrated**: Shares common infrastructure with Wine

## Installation

### Prerequisites

- GCC or Clang compiler
- GNU Make
- Autoconf and Automake
- X11 development files (xorg-dev or libX11-devel)
- flex (>= 2.5.33) and bison

### Building from Source

```bash
git clone https://github.com/charlieduzstuf/Goliath.git
cd Goliath
./autogen.sh
./configure --prefix=/usr/local
make
sudo make install
```

### Configuration Options

```bash
# Enable specific components
./configure --enable-darling --enable-atl

# Disable optional components
./configure --disable-darling
```

## Usage

### Unified Launcher

The `goliath-launch.sh` script automatically detects the application type and uses the appropriate compatibility layer:

```bash
# Run any supported application
./goliath-launch.sh myapp.exe      # Windows
./goliath-launch.sh myapp.app      # macOS (when available)
./goliath-launch.sh myapp.apk      # Android (when available)
```

### Direct Wine Usage

You can still use Wine directly for Windows applications:

```bash
wine myapp.exe
```

### Application Detection

Goliath detects application types using file signatures:
- **PE32/PE32+**: Windows executables → Wine
- **Mach-O**: macOS binaries → Darling
- **APK**: Android packages → ATL
- **IPA**: iOS packages → ipasim

## Components

### Wine (Base Layer)
- Windows API implementation
- Win32/Win64 application support
- Direct3D to OpenGL/Vulkan translation
- Windows driver support

### Darling (macOS Compatibility)
- Darwin system call translation
- Mach-O binary loader
- macOS frameworks (Cocoa, Foundation, etc.)
- Status: **In development**

### ATL (Android Translation Layer)
- Android NDK API support
- Native Android app execution
- JNI bridge for Java interaction
- Status: **Partial implementation**

### WSL Integration
- Hybrid Windows/Linux system calls
- NT kernel emulation improvements
- Status: **Planned**

### Libretro (Console Emulation)
- Unified console emulation frontend
- Support for multiple console platforms
- Status: **Planned**

### ipasim (iOS Simulation)
- iOS framework emulation
- ARM to x86/x64 translation
- Status: **Planned**

## Development

### Project Structure

```
Goliath/
├── dlls/                  # Wine DLLs
├── libs/
│   ├── darling/          # macOS compatibility
│   ├── atl_android/      # Android compatibility
│   └── ...               # Other components
├── include/              # Headers
├── tools/                # Build tools
├── documentation/
│   ├── ARCHITECTURE.md   # System architecture
│   ├── INTEGRATION.md    # Integration guide
│   └── README-goliath.md # This file
├── goliath-launch.sh     # Unified launcher
└── configure.ac          # Build configuration
```

### Contributing

See [INTEGRATION.md](INTEGRATION.md) for how to integrate new compatibility layers.

See [ARCHITECTURE.md](ARCHITECTURE.md) for system architecture details.

See [upstream-sync/README.md](upstream-sync/README.md) for how upstream dependencies are tracked and updated.

## Roadmap

### Phase 1: Foundation ✓
- Fix Wine build system
- Create integration framework
- Implement unified launcher

### Phase 2: Darling Integration (In Progress)
- Import Darling source
- Integrate Mach-O loader
- Test macOS applications

### Phase 3: Complete ATL Integration
- Finish Android support
- Add APK parsing
- Implement JNI bridge

### Phase 4: Additional Layers
- WSL compatibility concepts
- Libretro integration
- ipasim integration

### Phase 5: Optimization
- Shared memory management
- Unified process management
- Cross-layer IPC
- Performance tuning

## Configuration

Goliath uses Wine's configuration system. You can configure it using:

```bash
winecfg
```

Additional Goliath-specific configuration will be added as more components are integrated.

## Troubleshooting

### Build Issues

**Configure fails:**
```bash
# Regenerate build system
./autogen.sh
./configure
```

**Missing dependencies:**
```bash
# On Debian/Ubuntu
sudo apt-get install build-essential autoconf automake libtool \
                     flex bison libx11-dev

# On Fedora/RHEL
sudo dnf install gcc make autoconf automake libtool flex bison \
                 libX11-devel
```

### Runtime Issues

**Wine applications don't run:**
- Ensure Wine is properly configured: `winecfg`
- Check for missing 32-bit libraries on 64-bit systems
- See Wine documentation: https://www.winehq.org/

**Darling/ATL not available:**
- These components are still in development
- Check build configuration: `./configure --enable-darling --enable-atl`

## Technical Details

### How It Works

1. **Application Launch**: User runs `goliath-launch.sh <app>`
2. **Detection**: Script detects application type using `file` command
3. **Routing**: Application is routed to appropriate compatibility layer
4. **Execution**: Compatibility layer loads and executes the application

### File Type Detection

```bash
# Windows PE32
file myapp.exe → PE32 executable

# macOS Mach-O
file myapp.app/Contents/MacOS/myapp → Mach-O 64-bit executable

# Android APK
file myapp.apk → Zip archive (APK)
```

## Comparison with Other Projects

### vs. Wine alone
- **Wine**: Windows only
- **Goliath**: Windows + macOS + Android + iOS + Consoles

### vs. Multiple separate tools
- **Traditional**: Install Wine, Darling, ATL separately
- **Goliath**: Single unified installation and launcher

### vs. Proton
- **Proton**: Wine + gaming enhancements (Steam-focused)
- **Goliath**: Wine + multi-OS compatibility (general-purpose)

## Performance

Performance depends on the compatibility layer:
- **Wine**: Near-native for many applications
- **Darling**: Overhead from system call translation
- **ATL**: Depends on Android app complexity

Optimization is ongoing for all layers.

## Compatibility

### Windows Applications
- Excellent compatibility through Wine
- See Wine AppDB: https://appdb.winehq.org/

### macOS Applications
- In development, limited testing
- Goal: Support major macOS frameworks

### Android Applications
- Partial support for native Android apps
- JNI bridge in development

## License

Goliath is based on Wine and inherits its LGPL 2.1+ license.

Each integrated component retains its original license:
- **Wine**: LGPL 2.1+
- **Darling**: GPL 3.0
- **ATL**: Apache 2.0
- **Libretro**: MIT
- **ipasim**: MIT

See LICENSE and component-specific license files for details.

## References

### Upstream Projects
- [Wine](https://www.winehq.org/) - Windows compatibility
- [Darling](https://github.com/darlinghq/darling) - macOS compatibility
- [ATL](https://gitlab.com/android_translation_layer/android_translation_layer) - Android compatibility
- [WSL](https://github.com/microsoft/WSL) - Windows Subsystem for Linux
- [Libretro](https://github.com/libretro/libretro-common) - Console emulation
- [ipasim](https://github.com/ipasimulator/ipasim) - iOS simulation

### Documentation
- [Wine Developer Guide](https://wiki.winehq.org/Developer_Guide)
- [Darling Documentation](https://docs.darlinghq.org/)
- [ATL Documentation](https://gitlab.com/android_translation_layer/android_translation_layer/-/wikis/home)

## Community

- **GitHub**: https://github.com/charlieduzstuf/Goliath
- **Issues**: https://github.com/charlieduzstuf/Goliath/issues
- **Wine Forums**: https://forum.winehq.org/
- **IRC**: #WineHQ on libera.chat

## Acknowledgments

Goliath is built on the excellent work of:
- The Wine project team
- The Darling project team
- The ATL project team
- And many other open source projects

Special thanks to all contributors who make cross-platform compatibility possible.

