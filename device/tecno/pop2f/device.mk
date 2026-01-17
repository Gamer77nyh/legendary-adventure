# Device Configuration for Tecno Pop 2F

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Device identifier
PRODUCT_DEVICE := pop2f
PRODUCT_NAME := lineage_pop2f
PRODUCT_BRAND := TECNO
PRODUCT_MODEL := TECNO POP 2F
PRODUCT_MANUFACTURER := TECNO
PRODUCT_RELEASE_NAME := pop2f

# Boot animation
TARGET_SCREEN_HEIGHT := 960
TARGET_SCREEN_WIDTH := 480

# Audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    audio.usb.default \
    audio.r_submix.default \
    libaudio-resampler \
    tinymix

# Bluetooth
PRODUCT_PACKAGES += \
    libbt-vendor

# Camera
PRODUCT_PACKAGES += \
    Camera2 \
    Snap

# Display
PRODUCT_PACKAGES += \
    libion

# GPS
PRODUCT_PACKAGES += \
    gps.mt6580 \
    libcurl

# Wifi
PRODUCT_PACKAGES += \
    lib_driver_cmd_mt66xx \
    libwpa_client \
    hostapd \
    wpa_supplicant \
    wpa_supplicant.conf

PRODUCT_COPY_FILES += \
    device/tecno/pop2f/configs/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
    device/tecno/pop2f/configs/wifi/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf \
    device/tecno/pop2f/configs/wifi/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf

# Media
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video_le.xml:system/etc/media_codecs_google_video_le.xml

# Ramdisk
PRODUCT_COPY_FILES += \
    device/tecno/pop2f/rootdir/fstab.mt6580:root/fstab.mt6580 \
    device/tecno/pop2f/rootdir/init.mt6580.rc:root/init.mt6580.rc \
    device/tecno/pop2f/rootdir/init.mt6580.usb.rc:root/init.mt6580.usb.rc \
    device/tecno/pop2f/rootdir/ueventd.mt6580.rc:root/ueventd.mt6580.rc

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.faketouch.xml:system/etc/permissions/android.hardware.faketouch.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.xml:system/etc/permissions/android.hardware.touchscreen.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml

# HackOS - Security Tools Integration
PRODUCT_PACKAGES += \
    HackAI \
    HackTerminal \
    ToolManager \
    NetworkAnalyzer \
    PacketCapture \
    WiFiAnalyzer

# Security tools binaries
PRODUCT_COPY_FILES += \
    device/tecno/pop2f/prebuilt/tools/nmap:system/xbin/nmap \
    device/tecno/pop2f/prebuilt/tools/netcat:system/xbin/nc \
    device/tecno/pop2f/prebuilt/tools/tcpdump:system/xbin/tcpdump \
    device/tecno/pop2f/prebuilt/tools/aircrack-ng:system/xbin/aircrack-ng \
    device/tecno/pop2f/prebuilt/tools/airodump-ng:system/xbin/airodump-ng \
    device/tecno/pop2f/prebuilt/tools/aireplay-ng:system/xbin/aireplay-ng

# Python and dependencies for security tools
PRODUCT_PACKAGES += \
    python3 \
    python3-pip

# Root access via Magisk
PRODUCT_PACKAGES += \
    Magisk

# Overlay
DEVICE_PACKAGE_OVERLAYS += device/tecno/pop2f/overlay

# Properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.kernel.android.checkjni=0 \
    ro.telephony.ril_class=MT6580 \
    ro.telephony.ril.config=fakeiccid \
    persist.call_recording.enabled=true \
    persist.call_recording.src=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.config.alarm_alert=Alarm_Classic.ogg \
    ro.config.notification_sound=OnTheHunt.ogg \
    ro.carrier=unknown \
    ro.vendor.mediatek.platform=MT6580

# HackOS specific properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hackai.enabled=true \
    ro.hackai.version=1.0.0 \
    ro.security.tools.enabled=true \
    persist.sys.root.access=3 \
    ro.debuggable=1 \
    persist.service.adb.enable=1 \
    persist.service.debuggable=1 \
    persist.sys.usb.config=mtp,adb

# Dalvik heap
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapgrowthlimit=128m \
    dalvik.vm.heapsize=256m \
    dalvik.vm.heaptargetutilization=0.75 \
    dalvik.vm.heapminfree=512k \
    dalvik.vm.heapmaxfree=2m

# ART optimization
PRODUCT_PROPERTY_OVERRIDES += \
    pm.dexopt.first-boot=quicken \
    pm.dexopt.boot=verify \
    pm.dexopt.install=quicken \
    pm.dexopt.bg-dexopt=speed-profile \
    pm.dexopt.ab-ota=speed-profile \
    pm.dexopt.shared=speed

$(call inherit-product, vendor/tecno/pop2f/pop2f-vendor.mk)
