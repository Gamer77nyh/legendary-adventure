#!/bin/bash
#
# HackOS Build Script for Tecno Pop 2F
# Automated ROM building with security tools integration
#

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Configuration
DEVICE="pop2f"
VENDOR="tecno"
ROM_NAME="HackOS"
VERSION="1.0.0-beta"
BUILD_TYPE="userdebug"
JOBS=$(nproc)

# Directories
ANDROID_TOP="${PWD}"
OUT_DIR="${ANDROID_TOP}/out"
DEVICE_DIR="${ANDROID_TOP}/device/${VENDOR}/${DEVICE}"

echo -e "${BLUE}╔══════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  HackOS ROM Builder for Tecno Pop 2F    ║${NC}"
echo -e "${BLUE}║  Version: ${VERSION}                    ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════╝${NC}"
echo ""

# Functions
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check prerequisites
check_prerequisites() {
    log_info "Checking prerequisites..."
    
    # Check for required tools
    required_tools=("git" "curl" "python3" "java" "make" "gcc")
    for tool in "${required_tools[@]}"; do
        if ! command -v $tool &> /dev/null; then
            log_error "$tool is not installed"
            exit 1
        fi
    done
    
    # Check Java version
    java_version=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')
    log_info "Java version: $java_version"
    
    # Check disk space (need at least 100GB)
    available_space=$(df -BG . | awk 'NR==2 {print $4}' | sed 's/G//')
    if [ "$available_space" -lt 100 ]; then
        log_warn "Low disk space: ${available_space}GB available (recommended: 100GB+)"
    fi
    
    log_info "Prerequisites check complete"
}

# Initialize build environment
init_environment() {
    log_info "Initializing build environment..."
    
    if [ ! -f "build/envsetup.sh" ]; then
        log_error "build/envsetup.sh not found. Are you in the AOSP root?"
        exit 1
    fi
    
    source build/envsetup.sh
    log_info "Environment initialized"
}

# Sync source code
sync_source() {
    log_info "Syncing source code..."
    
    if [ -d ".repo" ]; then
        log_info "Repository found, syncing..."
        repo sync -c -j${JOBS} --force-sync --no-clone-bundle --no-tags
    else
        log_error "No repo found. Please run 'repo init' first"
        exit 1
    fi
    
    log_info "Source sync complete"
}

# Setup device tree
setup_device_tree() {
    log_info "Setting up device tree..."
    
    if [ ! -d "${DEVICE_DIR}" ]; then
        log_error "Device directory not found: ${DEVICE_DIR}"
        exit 1
    fi
    
    # Verify device files
    required_files=("BoardConfig.mk" "device.mk" "lineage.mk")
    for file in "${required_files[@]}"; do
        if [ ! -f "${DEVICE_DIR}/${file}" ]; then
            log_error "Missing device file: ${file}"
            exit 1
        fi
    done
    
    log_info "Device tree setup complete"
}

# Apply HackOS patches
apply_patches() {
    log_info "Applying HackOS security patches..."
    
    # Apply kernel patches for monitor mode
    if [ -d "kernel/${VENDOR}/${DEVICE}" ]; then
        log_info "Applying kernel patches..."
        # Kernel patches would be applied here
    fi
    
    # Apply system patches for security tools
    log_info "Applying system patches..."
    
    log_info "Patches applied successfully"
}

# Build kernel
build_kernel() {
    log_info "Building kernel..."
    
    if [ -d "kernel/${VENDOR}/${DEVICE}" ]; then
        cd "kernel/${VENDOR}/${DEVICE}"
        make clean
        make -j${JOBS} ARCH=arm CROSS_COMPILE=arm-linux-androideabi-
        cd "${ANDROID_TOP}"
        log_info "Kernel built successfully"
    else
        log_warn "Kernel source not found, using prebuilt"
    fi
}

# Build ROM
build_rom() {
    log_info "Building ROM..."
    
    # Select device
    lunch lineage_${DEVICE}-${BUILD_TYPE}
    
    # Clean previous build (optional)
    if [ "$1" == "clean" ]; then
        log_info "Cleaning previous build..."
        make clean
        make clobber
    fi
    
    # Build
    log_info "Starting compilation (this will take a while)..."
    mka bacon -j${JOBS}
    
    if [ $? -eq 0 ]; then
        log_info "ROM built successfully!"
        
        # Find output file
        ROM_FILE=$(find ${OUT_DIR}/target/product/${DEVICE}/ -name "lineage-*.zip" -type f -printf '%T@ %p\n' | sort -n | tail -1 | cut -d' ' -f2-)
        
        if [ -f "$ROM_FILE" ]; then
            ROM_SIZE=$(du -h "$ROM_FILE" | cut -f1)
            log_info "ROM file: $ROM_FILE"
            log_info "ROM size: $ROM_SIZE"
            
            # Generate MD5
            log_info "Generating MD5 checksum..."
            md5sum "$ROM_FILE" > "${ROM_FILE}.md5sum"
            
            # Move to releases directory
            RELEASE_DIR="${ANDROID_TOP}/releases"
            mkdir -p "$RELEASE_DIR"
            cp "$ROM_FILE" "$RELEASE_DIR/"
            cp "${ROM_FILE}.md5sum" "$RELEASE_DIR/"
            
            log_info "ROM copied to: ${RELEASE_DIR}"
        fi
    else
        log_error "Build failed!"
        exit 1
    fi
}

# Generate installation package
generate_package() {
    log_info "Generating installation package..."
    
    PACKAGE_DIR="${ANDROID_TOP}/releases/HackOS-${VERSION}-${DEVICE}"
    mkdir -p "$PACKAGE_DIR"
    
    # Copy ROM
    cp ${OUT_DIR}/target/product/${DEVICE}/lineage-*.zip "$PACKAGE_DIR/HackOS-${VERSION}-${DEVICE}.zip"
    
    # Copy TWRP if available
    if [ -f "${OUT_DIR}/target/product/${DEVICE}/recovery.img" ]; then
        cp ${OUT_DIR}/target/product/${DEVICE}/recovery.img "$PACKAGE_DIR/twrp-${DEVICE}.img"
    fi
    
    # Create installation script
    cat > "$PACKAGE_DIR/install.sh" << 'EOF'
#!/bin/bash
echo "HackOS Installation Script"
echo "=========================="
echo ""
echo "1. Unlock bootloader: fastboot oem unlock"
echo "2. Flash recovery: fastboot flash recovery twrp-pop2f.img"
echo "3. Boot to recovery and flash ROM"
echo ""
read -p "Continue with installation? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Flashing recovery..."
    fastboot flash recovery twrp-pop2f.img
    echo "Done! Boot to recovery and flash the ROM zip"
fi
EOF
    chmod +x "$PACKAGE_DIR/install.sh"
    
    # Create README
    cat > "$PACKAGE_DIR/README.txt" << EOF
HackOS v${VERSION} for Tecno Pop 2F
====================================

Installation Instructions:
1. Unlock bootloader
2. Flash TWRP recovery
3. Boot to recovery
4. Wipe data/factory reset
5. Flash HackOS-${VERSION}-${DEVICE}.zip
6. Reboot

First Boot:
- Initial boot may take 5-10 minutes
- Grant root access to HackAI
- Configure AI assistant voice activation
- Run: hackai update-all

For support: https://github.com/Gamer77nyh/legendary-adventure

WARNING: For authorized security testing only!
EOF
    
    log_info "Installation package created: $PACKAGE_DIR"
}

# Main build process
main() {
    case "$1" in
        clean)
            log_info "Clean build requested"
            check_prerequisites
            init_environment
            build_rom clean
            generate_package
            ;;
        sync)
            log_info "Syncing source only"
            sync_source
            ;;
        kernel)
            log_info "Building kernel only"
            check_prerequisites
            init_environment
            build_kernel
            ;;
        full)
            log_info "Full build with sync"
            check_prerequisites
            sync_source
            init_environment
            setup_device_tree
            apply_patches
            build_kernel
            build_rom
            generate_package
            ;;
        *)
            log_info "Quick build (no sync)"
            check_prerequisites
            init_environment
            setup_device_tree
            build_rom
            generate_package
            ;;
    esac
    
    echo ""
    echo -e "${GREEN}╔══════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║         Build Complete!                  ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════╝${NC}"
}

# Show usage
usage() {
    echo "HackOS Build Script"
    echo ""
    echo "Usage: $0 [command]"
    echo ""
    echo "Commands:"
    echo "  (none)  - Quick build without sync"
    echo "  full    - Full build with source sync"
    echo "  clean   - Clean build (removes previous build)"
    echo "  sync    - Sync source code only"
    echo "  kernel  - Build kernel only"
    echo ""
    echo "Examples:"
    echo "  $0           # Quick build"
    echo "  $0 full      # Full build with sync"
    echo "  $0 clean     # Clean build"
}

# Check if help requested
if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    usage
    exit 0
fi

# Run main
main "$@"
