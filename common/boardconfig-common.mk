#
# Copyright (C) 2019 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include build/make/target/board/BoardConfigMainlineCommon.mk

AB_OTA_UPDATER := false

TARGET_NO_KERNEL := false

BOARD_USES_RECOVERY_AS_BOOT := true

# generic wifi
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_HOSTAPD_DRIVER := NL80211
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true

# --- Android images ---
BOARD_FLASH_BLOCK_SIZE := 512

# User image
TARGET_COPY_OUT_DATA := data
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_PARTITION_SIZE := 33554432

BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4

# System image
#TARGET_COPY_OUT_SYSTEM := system
# Disable Jack build system due deprecated status (https://source.android.com/source/jack)
ANDROID_COMPILE_WITH_JACK ?= false

# Cache image 66 MiB
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE := $(shell echo $$(( 66 * 1024 * 1024 )))

# Vendor image 2GiB
BOARD_USES_VENDORIMAGE := true
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
#BOARD_VENDORIMAGE_PARTITION_SIZE := $(shell echo $$(( 2 * 1024 * 1024 * 1024 )))

# Boot image 32 MiB
BOARD_BOOTIMAGE_PARTITION_SIZE := $(shell echo $$(( 32 * 1024 * 1024 )))
BOARD_DTBOIMG_PARTITION_SIZE := $(shell echo $$(( 512 * 1024 )))

# Root image
TARGET_COPY_OUT_ROOT := root
BOARD_BUILD_SYSTEM_ROOT_IMAGE := false

# Recovery image
TARGET_COPY_OUT_RECOVERY := recovery

BOARD_EXT4_SHARE_DUP_BLOCKS := true

# Dynamic partition 1800 MiB
BOARD_SUPER_PARTITION_SIZE := $(shell echo $$(( 1800 * 1024 * 1024 )))
BOARD_BUILD_SUPER_IMAGE_BY_DEFAULT := true
BOARD_SUPER_PARTITION_GROUPS := glodroid_dynamic_partitions
BOARD_GLODROID_DYNAMIC_PARTITIONS_SIZE := $(shell echo $$(( $(BOARD_SUPER_PARTITION_SIZE) - (10 * 1024 * 1024) )))
BOARD_GLODROID_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext vendor product

TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888

# Kernel build rules
BOARD_INCLUDE_RECOVERY_DTBO := true
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_PREBUILT_DTBIMAGE_DIR := device/glodroid/platform/kernel
BOARD_BOOT_HEADER_VERSION := 2
ifeq ($(PRODUCT_BOARD_PLATFORM),sunxi)
BOARD_KERNEL_BASE     := 0x40000000
endif
ifeq ($(PRODUCT_BOARD_PLATFORM),broadcom)
BOARD_KERNEL_BASE     := 0x00000000
endif
ifeq ($(PRODUCT_BOARD_PLATFORM),rockchip)
BOARD_KERNEL_BASE     := 0x2000000
endif
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_CMDLINE  := androidboot.hardware=$(TARGET_PRODUCT)
BOARD_MKBOOTIMG_ARGS  += --kernel_offset 0x80000 --second_offset 0x8800 --ramdisk_offset 0x3300000
BOARD_MKBOOTIMG_ARGS  += --dtb_offset 0x3000000 --header_version $(BOARD_BOOT_HEADER_VERSION)
TARGET_KERNEL_SOURCE  := kernel/glodroid

BOARD_RAMDISK_USE_LZ4 := true

# SELinux support
#BOARD_SEPOLICY_DIRS += build/target/board/generic/sepolicy

BOARD_USES_TINYHAL_AUDIO := true
TINYCOMPRESS_TSTAMP_IS_LONG := true
TINYALSA_NO_ADD_NEW_CTRLS := true
TINYALSA_NO_CTL_GET_ID := true
#USE_CAMERA_STUB := true
USE_OPENGL_RENDERER := true
BOARD_USE_LEGACY_UI := true

BOARD_MESA3D_USES_MESON_BUILD := true
BOARD_MESA3D_GALLIUM_DRIVERS := lima

BOARD_USES_METADATA_PARTITION := true

BOARD_USES_PRODUCTIMAGE := true
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4

# Enable dex-preoptimization to speed up first boot sequence
DEX_PREOPT_DEFAULT := nostripping
WITH_DEXPREOPT := true
ART_USE_HSPACE_COMPACT := true

DEVICE_MANIFEST_FILE := device/glodroid/common/manifest.xml
DEVICE_MATRIX_FILE := device/glodroid/common/compatibility_matrix.xml

# SELinux support
BOARD_VENDOR_SEPOLICY_DIRS       += device/glodroid/common/sepolicy/vendor

BOARD_USES_GRALLOC_HANDLE := true

BOARD_LIBCAMERA_USES_MESON_BUILD := true
BOARD_LIBCAMERA_IPAS := raspberrypi
BOARD_LIBCAMERA_PIPELINES := simple raspberrypi uvcvideo
