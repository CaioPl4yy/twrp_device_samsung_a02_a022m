# TWRP device tree: Galaxy A02 (SM-A022M)

Device tree for the A022M (MT6739, Android 11, firmware A022MUBS4BWL2), based on the A022F version and corrected with the device's actual data. NOT TESTED.

Before compiling:
The `prebuilt/` directory is already populated (containing the kernel, `dtb.img`, and `dtbo.img` from the A022M stock recovery).
The `recovery/root/` directory already includes `init.recovery.mt6739.rc` (adjusted for USB configfs) and `init.recovery.samsung.rc`, both taken from the A022M stock recovery.
Check the remaining TODO items in `BoardConfig.mk` (screen brightness).
To compile:
Go to Actions > "Build TWRP A022M" > Run workflow. The output will be available under Artifacts (as `recovery.img` and `recovery.tar` for Odin). The job will fail if `recovery.img` exceeds 25,165,824 bytes (24 MiB).
Hold on a second! I’ll compile it for you—the second release is on its way!
