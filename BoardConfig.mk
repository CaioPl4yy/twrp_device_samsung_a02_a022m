#
# Copyright (C) 2023 The Android Open Source Project
# Copyright (C) 2023 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#
# Galaxy A02 (SM-A022M), firmware A022MUBS4BWL2, MT6739.
# Base: pachdomenic/twrp_device_samsung_a02 (A022F), conferida contra os
# dados reais do A022M. Linhas com "TODO" ainda precisam ser conferidas.
#

DEVICE_PATH := device/samsung/a02

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

# Architecture (uname -m = armv7l, zygote32)
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a53
TARGET_USES_64_BIT_BINDER := true

# APEX
DEXPREOPT_GENERATE_APEX_IMAGE := true

# Bootloader (ro.product.board)
TARGET_BOOTLOADER_BOARD_NAME := k39tv1_bsp_titan_hamster
TARGET_NO_BOOTLOADER := true

# Display
TARGET_SCREEN_DENSITY := 300

# Kernel (header v2; kernel em 0x40008000, que e a base + offset padrao 0x8000)
BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_KERNEL_BASE := 0x40000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_RAMDISK_OFFSET := 0x05000000
BOARD_KERNEL_TAGS_OFFSET := 0x04000000
# cmdline, nome da placa e dtb offset conferidos no header do recovery.img stock
# do A022M (dtb_addr = 0x44000000 = base + 0x04000000, igual ao tags offset)
BOARD_KERNEL_CMDLINE := bootopt=64S3,32S1,32S1
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb_offset 0x04000000
BOARD_MKBOOTIMG_ARGS += --board SRPTL30A004
BOARD_KERNEL_IMAGE_NAME := zImage

# Kernel - prebuilt (extraidos do recovery.img stock do A022M)
# Kernel 4.14.186 zImage de 32 bits; so ha CONFIG_RD_GZIP, entao o ramdisk
# tem que ser gzip (nao usar BOARD_RAMDISK_USE_LZMA).
TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img
BOARD_INCLUDE_RECOVERY_DTBO := true

# Partitions (PIT do A022M)
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 25165824
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 25165824
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_ODM := odm

# Dynamic partitions: super = 3880 MiB, grupo "main" (valores do A022M)
BOARD_SUPER_PARTITION_SIZE := 4068474880
BOARD_SUPER_PARTITION_GROUPS := main
BOARD_MAIN_SIZE := 4064280576
BOARD_MAIN_PARTITION_LIST := system vendor product odm

# Platform
TARGET_BOARD_PLATFORM := mt6739

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/recovery.fstab
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Security patch level (anti-rollback hack)
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION := 16.1.0

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

# Criptografia do /data (FBE: aes-256-xts:aes-256-cts:v1, keymaster em TEEGRIS)
# DESLIGADO na primeira compilacao: com o keymaster da Samsung no TEE e
# provavel que o TWRP nao consiga descriptografar. Ligar so depois de a
# imagem basica subir.
# TW_INCLUDE_CRYPTO := true
# TW_INCLUDE_CRYPTO_FBE := true
# BOARD_USES_METADATA_PARTITION := true

# TWRP Configuration
TW_MTP_DEVICE := "Galaxy A02"
TW_DEVICE_VERSION := A022M-test1
# TODO: caminho e brilho maximo vieram da arvore do A022F, nao conferidos
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel/brightness"
TW_MAX_BRIGHTNESS := 306
TW_DEFAULT_BRIGHTNESS := 120
TW_NO_REBOOT_BOOTLOADER := true
TW_HAS_DOWNLOAD_MODE := true
TARGET_SCREEN_WIDTH := 720
TARGET_SCREEN_HEIGHT := 1600
TW_THEME := portrait_hdpi
# Desligado para economizar espaco: kernel (10,1 MiB) + dtb + dtbo ja ocupam
# cerca de 10,4 MiB dos 24 MiB, e o ramdisk precisa caber em gzip.
TW_EXTRA_LANGUAGES := false
TW_SCREEN_BLANK_ON_BOOT := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_USE_TOOLBOX := true
RECOVERY_SDCARD_ON_DATA := true
TW_EXTERNAL_STORAGE_PATH := "/external_sd"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "external_sd"
