# LineageOS Configuration for Tecno Pop 2F

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from device
$(call inherit-product, device/tecno/pop2f/device.mk)

# Inherit some common LineageOS stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Device identifier
PRODUCT_NAME := lineage_pop2f
PRODUCT_DEVICE := pop2f
PRODUCT_BRAND := TECNO
PRODUCT_MODEL := TECNO POP 2F
PRODUCT_MANUFACTURER := TECNO

# Build fingerprint
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="full_pop2f-user 8.1.0 O11019 1537347993 release-keys"

BUILD_FINGERPRINT := TECNO/H633/TECNO-POP2F:8.1.0/O11019/B-180919V133:user/release-keys

# HackOS Version
HACKAI_VERSION := 1.0.0-beta
HACKAI_BUILD_TYPE := UNOFFICIAL

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hackai.version=$(HACKAI_VERSION) \
    ro.hackai.build.type=$(HACKAI_BUILD_TYPE) \
    ro.modversion=HackOS-$(HACKAI_VERSION)-$(PRODUCT_DEVICE)
