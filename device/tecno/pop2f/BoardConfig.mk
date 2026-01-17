# Board Configuration for Tecno Pop 2F (B1F)

# Platform
TARGET_BOARD_PLATFORM := mt6580
TARGET_NO_BOOTLOADER := true
TARGET_BOOTLOADER_BOARD_NAME := mt6580

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := cortex-a7
TARGET_CPU_SMP := true

# Kernel
TARGET_KERNEL_SOURCE := kernel/tecno/pop2f
TARGET_KERNEL_CONFIG := pop2f_defconfig
TARGET_KERNEL_CROSS_COMPILE_PREFIX := arm-linux-androideabi-
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
BOARD_KERNEL_BASE := 0x40000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_MKBOOTIMG_ARGS := --base 0x40000000 --pagesize 2048 --kernel_offset 0x00008000 --ramdisk_offset 0x04000000 --tags_offset 0x0e000000

# Custom kernel features for security tools
BOARD_KERNEL_CMDLINE += androidboot.hardware=mt6580
TARGET_KERNEL_ADDITIONAL_FLAGS := HOSTCFLAGS="-fuse-ld=lld -Wno-unused-command-line-argument"

# Wireless
BOARD_WLAN_DEVICE := MediaTek
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_HOSTAPD_DRIVER := NL80211
WIFI_DRIVER_FW_PATH_PARAM := "/dev/wmtWifi"
WIFI_DRIVER_FW_PATH_STA := STA
WIFI_DRIVER_FW_PATH_AP := AP
WIFI_DRIVER_FW_PATH_P2P := P2P
WIFI_DRIVER_MODULE_PATH := "/system/lib/modules/wlan_mt.ko"
WIFI_DRIVER_MODULE_NAME := "wlan_mt"

# Monitor mode support for packet injection
BOARD_HAVE_MEDIATEK_WIFI := true
MTK_WLAN_SUPPORT := yes
WIFI_HIDL_FEATURE_AWARE := true

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/tecno/pop2f/bluetooth

# Display
TARGET_SCREEN_WIDTH := 480
TARGET_SCREEN_HEIGHT := 960
TARGET_SCREEN_DENSITY := 160

# Graphics
USE_OPENGL_RENDERER := true
TARGET_USES_ION := true
BOARD_EGL_CFG := device/tecno/pop2f/configs/egl.cfg

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 16777216
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2147483648
BOARD_USERDATAIMAGE_PARTITION_SIZE := 13421772800
BOARD_CACHEIMAGE_PARTITION_SIZE := 419430400
BOARD_FLASH_BLOCK_SIZE := 131072

# Filesystem
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_HAS_LARGE_FILESYSTEM := true

# Recovery
TARGET_RECOVERY_FSTAB := device/tecno/pop2f/rootdir/etc/fstab.mt6580
BOARD_HAS_NO_SELECT_BUTTON := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGBA_8888"

# TWRP specific
TW_THEME := portrait_hdpi
RECOVERY_GRAPHICS_USE_LINELENGTH := true
TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 128
TW_CUSTOM_CPU_TEMP_PATH := /sys/devices/virtual/thermal/thermal_zone1/temp
TW_USE_TOOLBOX := true
TW_EXCLUDE_SUPERSU := true
TW_INCLUDE_CRYPTO := true
TW_CRYPTO_USE_SYSTEM_VOLD := true

# SELinux
BOARD_SEPOLICY_DIRS += device/tecno/pop2f/sepolicy
BOARD_PLAT_PUBLIC_SEPOLICY_DIR += device/tecno/pop2f/sepolicy/public
BOARD_PLAT_PRIVATE_SEPOLICY_DIR += device/tecno/pop2f/sepolicy/private

# Security Tools - Allow packet capture and raw sockets
BOARD_SEPOLICY_UNION += \
    netutils.te \
    system_app.te \
    untrusted_app.te \
    platform_app.te

# Root access
WITH_SU := true

# Additional flags for security tools
TARGET_KERNEL_HAVE_WIRELESS_EXT := true
TARGET_KERNEL_HAVE_EXFAT := true
TARGET_KERNEL_HAVE_NTFS := true

# Custom additions for HackOS
BOARD_CUSTOM_BOOTIMG_MK := device/tecno/pop2f/boot.mk
BOARD_CUSTOM_GRAPHICS := ../../../device/tecno/pop2f/recovery/graphics.c
