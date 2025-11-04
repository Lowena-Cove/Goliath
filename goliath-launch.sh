#!/usr/bin/env bash
# Goliath Unified Compatibility Layer Launcher
#
# This is the unified launcher and integration point for:
# - Wine (Windows compatibility)
# - Darling (macOS compatibility)
# - ATL (Android Translation Layer)
# - ipasim (iOS simulation)
# - Libretro (console emulation)
# - WSL (Linux/Windows hybrid concepts)
#
# Usage: ./goliath-launch.sh <application> [args...]
#
# This script auto-detects the application type and dispatches to the correct subsystem.
# All subsystems are now fully integrated into Goliath's source tree.
#
# Copyright 2025 Goliath Project

set -e

GOLIATH_VERSION="1.0.0"
GOLIATH_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
    cat << EOF
Goliath Unified Compatibility Layer v${GOLIATH_VERSION}

Usage: $0 <application> [args...]

Runs applications from multiple operating systems using the appropriate compatibility layer:
  - Windows (.exe, .dll) via Wine
  - macOS (.app, Mach-O) via Darling
  - Android (.apk) via ATL
  - iOS (.ipa) via ipasim
  - Console ROMs via Libretro

Options:
  -h, --help        Show this help message
  -v, --version     Show version information
  --force-layer     Force a specific compatibility layer (wine|darling|atl|ipasim|libretro)
  --debug           Enable debug output

Examples:
  $0 notepad.exe                    # Run Windows application
  $0 /Applications/Safari.app       # Run macOS application
  $0 myapp.apk                      # Run Android application
  $0 myapp.ipa                      # Run iOS application
  $0 game.nes --force-layer=libretro # Run NES ROM

For more information, see documentation/README-goliath.md
EOF
    exit 0
}

version() {
    echo "Goliath v${GOLIATH_VERSION}"
    echo "Copyright (C) 2025 Goliath Project"
    echo ""
    echo "Based on:"
    echo "  Wine $(wine --version 2>/dev/null || echo 'not installed')"
    echo "  Darling (integrated)"
    echo "  ATL (integrated)"
    echo "  ipasim (integrated)"
    echo "  Libretro (integrated)"
    echo "  WSL concepts (integrated)"
    exit 0
}

# Parse options
FORCE_LAYER=""
DEBUG_MODE=0

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            usage
            ;;
        -v|--version)
            version
            ;;
        --force-layer=*)
            FORCE_LAYER="${1#*=}"
            shift
            ;;
        --debug)
            DEBUG_MODE=1
            shift
            ;;
        *)
            break
            ;;
    esac
done

if [ $# -lt 1 ]; then
    usage
fi

APP="$1"
shift

# Debug output
debug() {
    if [ $DEBUG_MODE -eq 1 ]; then
        echo "[DEBUG] $*" >&2
    fi
}

# Check if file exists
if [ ! -e "$APP" ]; then
    echo "[Goliath] Error: Application not found: $APP" >&2
    exit 2
fi

# Get file type
filetype=$(file -b "$APP")
debug "File type: $filetype"

# Detect application type and dispatch
detect_and_launch() {
    local app="$1"
    shift
    
    # Force specific layer if requested
    if [ -n "$FORCE_LAYER" ]; then
        debug "Forcing layer: $FORCE_LAYER"
        case "$FORCE_LAYER" in
            wine)
                exec wine "$app" "$@"
                ;;
            darling)
                exec darling shell "$app" "$@"
                ;;
            atl)
                exec atl "$app" "$@"
                ;;
            ipasim)
                exec ipasim "$app" "$@"
                ;;
            libretro)
                exec retroarch -L auto "$app" "$@"
                ;;
            *)
                echo "[Goliath] Error: Unknown layer: $FORCE_LAYER" >&2
                exit 2
                ;;
        esac
    fi
    
    # Auto-detect based on file type
    if [[ "$filetype" == *"PE32"* || "$filetype" == *"MS Windows"* || "$filetype" == *"MS-DOS"* ]]; then
        # Windows binary
        debug "Detected: Windows application"
        echo "[Goliath] Launching Windows application via Wine..."
        exec wine "$app" "$@"
        
    elif [[ "$filetype" == *"Mach-O"* ]]; then
        # macOS binary
        debug "Detected: macOS application"
        echo "[Goliath] Launching macOS application via Darling..."
        exec darling shell "$app" "$@"
        
    elif [[ "$app" == *.app ]] || [[ "$app" == *.app/* ]]; then
        # macOS application bundle
        debug "Detected: macOS application bundle"
        echo "[Goliath] Launching macOS application bundle via Darling..."
        exec darling shell "$app" "$@"
        
    elif [[ "$filetype" == *"Zip archive"* && "$app" == *.apk ]]; then
        # Android APK
        debug "Detected: Android APK"
        echo "[Goliath] Launching Android application via ATL..."
        exec atl "$app" "$@"
        
    elif [[ "$filetype" == *"Zip archive"* && "$app" == *.ipa ]]; then
        # iOS IPA
        debug "Detected: iOS IPA"
        echo "[Goliath] Launching iOS application via ipasim..."
        exec ipasim "$app" "$@"
        
    elif [[ "$app" == *.nes || "$app" == *.snes || "$app" == *.gba || "$app" == *.n64 || "$app" == *.nds ]]; then
        # Nintendo console ROMs
        debug "Detected: Nintendo console ROM"
        echo "[Goliath] Launching console ROM via Libretro..."
        exec retroarch -L auto "$app" "$@"
        
    elif [[ "$app" == *.gb || "$app" == *.gbc ]]; then
        # Game Boy ROMs
        debug "Detected: Game Boy ROM"
        echo "[Goliath] Launching Game Boy ROM via Libretro..."
        exec retroarch -L auto "$app" "$@"
        
    elif [[ "$app" == *.smd || "$app" == *.gen ]]; then
        # Sega Genesis/Mega Drive ROMs
        debug "Detected: Sega Genesis ROM"
        echo "[Goliath] Launching Genesis ROM via Libretro..."
        exec retroarch -L auto "$app" "$@"
        
    elif [[ "$app" == *.iso && "$filetype" == *"ISO 9660"* ]]; then
        # CD/DVD ISO (could be game or application)
        debug "Detected: ISO image"
        echo "[Goliath] Detected ISO image. Please specify --force-layer for disambiguation."
        echo "  --force-layer=wine      (Windows game/app)"
        echo "  --force-layer=libretro  (Console game)"
        exit 2
        
    elif [[ "$filetype" == *"ELF"* ]]; then
        # ELF binary (Linux native or Android native)
        debug "Detected: ELF binary"
        if [[ "$app" == *android* || "$app" == *"arm"* ]]; then
            echo "[Goliath] Launching Android ELF via ATL..."
            exec atl "$app" "$@"
        else
            echo "[Goliath] ELF binaries should run natively on Linux."
            echo "[Goliath] Attempting direct execution..."
            exec "$app" "$@"
        fi
        
    else
        # Unknown type
        echo "[Goliath] Unknown or unsupported application type: $filetype" >&2
        echo "[Goliath] File: $app" >&2
        echo "[Goliath] Use --force-layer to specify the compatibility layer manually." >&2
        exit 2
    fi
}

# Launch the application
detect_and_launch "$APP" "$@"

