# Building HackOS from Source

Complete guide for building HackOS custom ROM for Tecno Pop 2F from source code.

## Table of Contents

- [Prerequisites](#prerequisites)
- [System Requirements](#system-requirements)
- [Setting Up Build Environment](#setting-up-build-environment)
- [Downloading Source Code](#downloading-source-code)
- [Building the ROM](#building-the-rom)
- [Troubleshooting](#troubleshooting)

## Prerequisites

### Hardware Requirements

- **CPU**: 64-bit multi-core processor (8+ cores recommended)
- **RAM**: 16GB minimum (32GB recommended)
- **Storage**: 200GB+ free disk space (SSD highly recommended)
- **OS**: Linux (Ubuntu 20.04 LTS or newer recommended)

### Required Software

```bash
# Ubuntu/Debian
sudo apt-get install bc bison build-essential ccache curl flex \
    g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev \
    lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev \
    libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush \
    rsync schedtool squashfs-tools xsltproc zip zlib1g-dev openjdk-8-jdk \
    python3 python3-pip
```

## System Requirements

### Configure Git

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

### Install Repo Tool

```bash
mkdir -p ~/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
export PATH=~/bin:$PATH
```

Add to `~/.bashrc`:
```bash
export PATH=~/bin:$PATH
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
ccache -M 50G
```

## Setting Up Build Environment

### 1. Create Working Directory

```bash
mkdir -p ~/hackai
cd ~/hackai
```

### 2. Initialize Repository

```bash
# Initialize LineageOS 14.1 (Android 7.1.2) repository
repo init -u https://github.com/LineageOS/android.git -b cm-14.1

# Or use our forked manifest for HackOS
repo init -u https://github.com/Gamer77nyh/legendary-adventure.git -b hackai-7.1
```

### 3. Create Local Manifests

Create `.repo/local_manifests/roomservice.xml`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
    <!-- Device tree -->
    <project name="Gamer77nyh/android_device_tecno_pop2f" 
             path="device/tecno/pop2f" 
             remote="github" 
             revision="hackai-7.1" />
    
    <!-- Vendor blobs -->
    <project name="Gamer77nyh/android_vendor_tecno_pop2f" 
             path="vendor/tecno/pop2f" 
             remote="github" 
             revision="hackai-7.1" />
    
    <!-- Kernel -->
    <project name="Gamer77nyh/android_kernel_tecno_pop2f" 
             path="kernel/tecno/pop2f" 
             remote="github" 
             revision="hackai-7.1" />
    
    <!-- HackAI App -->
    <project name="Gamer77nyh/HackAI" 
             path="packages/apps/HackAI" 
             remote="github" 
             revision="master" />
</manifest>
```

## Downloading Source Code

### Sync All Repositories

```bash
# Initial sync (will take a while - 50GB+ download)
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# The -c flag fetches only the current branch
# -j$(nproc --all) uses all CPU cores for parallel download
```

### Verify Sync

```bash
# Check if all repositories synced successfully
repo status

# Should show clean working directories
```

## Building the ROM

### Method 1: Using Build Script (Recommended)

```bash
# Clone this repository
git clone https://github.com/Gamer77nyh/legendary-adventure.git
cd legendary-adventure

# Make script executable
chmod +x build_rom.sh

# Run build
./build_rom.sh

# For full build with sync
./build_rom.sh full

# For clean build
./build_rom.sh clean
```

### Method 2: Manual Build

```bash
# Navigate to source root
cd ~/hackai

# Initialize build environment
source build/envsetup.sh

# Select device
lunch lineage_pop2f-userdebug

# Start build
mka bacon -j$(nproc --all)
```

### Build Options

- **userdebug**: Development build with root access (recommended)
- **user**: Production build without root
- **eng**: Engineering build with all debugging

### Build Time

- First build: 2-6 hours (depending on hardware)
- Incremental builds: 15-45 minutes
- Clean builds: 1-3 hours

## Build Output

Successful build will produce:

```
out/target/product/pop2f/
├── lineage-14.1-YYYYMMDD-UNOFFICIAL-pop2f.zip  # ROM package
├── recovery.img                                  # Recovery image
├── boot.img                                      # Boot image
└── system.img                                    # System partition
```

### Verify Build

```bash
# Check ROM size (should be ~500-700MB)
ls -lh out/target/product/pop2f/*.zip

# Verify MD5 checksum
md5sum out/target/product/pop2f/lineage-*.zip
```

## Advanced Build Options

### Building Specific Components

```bash
# Build kernel only
cd kernel/tecno/pop2f
export ARCH=arm
export CROSS_COMPILE=arm-linux-androideabi-
make pop2f_defconfig
make -j$(nproc --all)

# Build HackAI app only
cd packages/apps/HackAI
mm

# Build recovery only
cd bootable/recovery
mm
```

### Customize Build

Edit `device/tecno/pop2f/lineage.mk`:

```makefile
# Add/remove packages
PRODUCT_PACKAGES += \
    YourCustomApp

# Modify build properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.custom.property=value
```

### Enable/Disable Features

Edit `device/tecno/pop2f/BoardConfig.mk`:

```makefile
# Enable additional features
BOARD_HAVE_CUSTOM_FEATURE := true

# Disable unwanted features
BOARD_UNWANTED_FEATURE := false
```

## Optimization Tips

### Use ccache

```bash
# Enable ccache
export USE_CCACHE=1
export CCACHE_DIR=~/.ccache
ccache -M 50G

# Monitor ccache
watch -n 1 ccache -s
```

### Increase Build Speed

```bash
# Use all CPU cores
export MAKEFLAGS="-j$(nproc --all)"

# Use more RAM for Java
export ANDROID_JACK_VM_ARGS="-Xmx4g -Dfile.encoding=UTF-8 -XX:+TieredCompilation"
```

### Parallel Repo Sync

```bash
# Faster repo sync
repo sync -c -j8 --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune
```

## Troubleshooting

### Common Build Errors

#### Out of Memory

```bash
# Reduce parallel jobs
make -j4 bacon

# Increase swap space
sudo fallocate -l 16G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

#### Missing Dependencies

```bash
# Install missing packages
sudo apt-get install -f

# For 32-bit libraries on 64-bit system
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install libc6:i386 libstdc++6:i386
```

#### Repo Sync Failures

```bash
# Force sync
repo sync --force-broken

# Reset specific project
repo sync -d project/path
```

#### Build Failures

```bash
# Clean and rebuild
make clean
make clobber
repo sync -j4
source build/envsetup.sh
lunch lineage_pop2f-userdebug
mka bacon
```

### Getting Help

- Check build logs in `out/` directory
- Search for error messages online
- Ask in [GitHub Discussions](https://github.com/Gamer77nyh/legendary-adventure/discussions)
- Report bugs in [Issues](https://github.com/Gamer77nyh/legendary-adventure/issues)

## Post-Build

### Extract Vendor Blobs

If building for the first time:

```bash
cd device/tecno/pop2f
./extract-files.sh
```

### Create Flashable Package

```bash
# Package is automatically created at:
# out/target/product/pop2f/lineage-*.zip

# Copy to safe location
cp out/target/product/pop2f/lineage-*.zip ~/Downloads/
```

### Test the ROM

1. Flash on device (see [Installation Guide](../README.md#installation))
2. Test basic functionality
3. Test security tools
4. Test AI assistant
5. Report issues

## Contributing

See [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines on submitting patches and improvements.

## Resources

- [LineageOS Build Guide](https://wiki.lineageos.org/devices/pop2f/build)
- [Android Source Building](https://source.android.com/setup/build/building)
- [AOSP Documentation](https://source.android.com/)
- [XDA Developers](https://forum.xda-developers.com/)

---

**Happy Building!** 🚀
