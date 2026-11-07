# TWRP device tree: Galaxy A02 (SM-A022M)

Device tree for the A022M (MT6739, Android 11, firmware A022MUBS4BWL2), based on the
A022F tree and corrected with the device's actual data. NOT TESTED.

## Before building
1. `prebuilt/` is already populated (kernel, dtb.img, and dtbo.img from the A022M stock recovery).
2. Copy `init.recovery.mt6739.rc` and `init.recovery.samsung.rc` from the A022F tree
to `recovery/root/` (review them first: they may contain A022F-specific settings).
3. Check the remaining `TODO` items in `BoardConfig.mk` (screen brightness).

## Building
Actions > "Build TWRP A022M" > Run workflow. The output can be found under Artifacts
(`recovery.img` and `recovery.tar` for Odin). The job will fail if the `recovery.img`
exceeds 25,165,824 bytes (24 MiB).
Whoa! Did you think I’d leave you hanging? Nope! It’s already built! Check the releases.
