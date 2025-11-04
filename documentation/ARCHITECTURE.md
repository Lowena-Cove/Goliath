# Goliath Architecture

## Overview

Goliath is a unified compatibility layer that integrates multiple OS compatibility tools into Wine's infrastructure. The goal is to provide a single platform that can run applications from Windows, macOS, Android, iOS, and console systems.

## Integration Architecture

### Core Components

1. **Wine** (Base Layer)
   - Windows application compatibility
   - Provides the core infrastructure and build system
   - Located in the main source tree

2. **Darling** (macOS Compatibility)
   - macOS/Darwin system call translation
   - Mach-O binary loading
   - macOS frameworks emulation
   - Integration: `libs/darling/`

3. **ATL** (Android Translation Layer)
   - Android application compatibility
   - Native Android NDK API support
   - Integration: `libs/atl_android/`

4. **WSL Integration** (Linux on Windows concepts reversed)
   - System call translation for hybrid environments
   - Integration: TBD

5. **Libretro** (Console Emulation)
   - Unified frontend for console emulators
   - Support for multiple console platforms
   - Integration: TBD

6. **ipasim** (iOS Simulation)
   - iOS application simulation
   - ARM to x86 translation
   - Integration: TBD

### Integration Strategy

The integration follows a **modular architecture** where each compatibility layer is:

1. **Optional**: Can be enabled/disabled at build time
2. **Isolated**: Each layer maintains its own codebase in `libs/`
3. **Unified**: All layers share common infrastructure (memory management, threading, etc.)
4. **Coordinated**: The `goliath-launch.sh` script provides a unified entry point

### Build System Integration

```
configure --enable-darling --enable-atl --enable-libretro --enable-ipasim
```

Each component can be individually enabled or disabled during configuration.

### Directory Structure

```
Goliath/
├── dlls/                    # Wine DLLs
├── libs/
│   ├── darling/            # Darling integration
│   ├── atl_android/        # Android Translation Layer
│   ├── wsl/               # WSL integration (future)
│   ├── libretro/          # Libretro integration (future)
│   └── ipasim/            # iOS simulation (future)
├── include/                # Shared headers
├── tools/                  # Build tools
├── goliath-launch.sh      # Unified launcher
└── documentation/
    └── README-goliath.md  # Goliath documentation
```

## Runtime Architecture

### Application Detection

The `goliath-launch.sh` script uses file type detection to determine the appropriate compatibility layer:

- **PE32/MS Windows**: Wine
- **Mach-O**: Darling
- **APK**: ATL (Android Translation Layer)
- **IPA**: ipasim (iOS)
- **Console ROMs**: Libretro (based on extension)

### Execution Flow

```
User runs: ./goliath-launch.sh <app>
    ↓
Detect application type
    ↓
Route to appropriate compatibility layer
    ↓
Load shared Goliath infrastructure
    ↓
Execute application
```

## Development Roadmap

### Phase 1: Foundation (Current)
- [x] Fix Wine build system issues
- [x] Create basic integration framework
- [x] Add darling stub library
- [x] Implement unified launcher script

### Phase 2: Darling Integration
- [ ] Import Darling source code
- [ ] Integrate Darling's Mach-O loader
- [ ] Connect Darling system call translation
- [ ] Test with macOS applications

### Phase 3: Additional Layers
- [ ] Complete ATL integration (currently stubbed)
- [ ] Add WSL compatibility concepts
- [ ] Integrate Libretro for console emulation
- [ ] Add ipasim for iOS support

### Phase 4: Optimization
- [ ] Shared memory management
- [ ] Unified process management
- [ ] Cross-layer IPC mechanisms
- [ ] Performance optimization

## Building Goliath

```bash
./autogen.sh
./configure --prefix=/usr/local
make
sudo make install
```

## Using Goliath

### Running Applications

```bash
# Windows application
./goliath-launch.sh myapp.exe

# macOS application (when Darling is integrated)
./goliath-launch.sh myapp.app

# Android APK (when ATL is complete)
./goliath-launch.sh myapp.apk
```

### Configuration

Goliath uses the same configuration as Wine:
```bash
winecfg  # or goliath-config in future
```

## Contributing

See CONTRIBUTING.md for guidelines on contributing to Goliath.

## License

Goliath inherits Wine's LGPL license. Each integrated component maintains its original license:
- Wine: LGPL 2.1+
- Darling: GPL 3.0
- ATL: Apache 2.0
- Other components: See respective licenses

## References

- [Wine](https://www.winehq.org/)
- [Darling](https://github.com/darlinghq/darling)
- [ATL](https://gitlab.com/android_translation_layer/android_translation_layer)
- [WSL](https://github.com/microsoft/WSL)
- [Libretro](https://github.com/libretro/libretro-common)
- [ipasim](https://github.com/ipasimulator/ipasim)
