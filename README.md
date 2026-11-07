# TWRP device tree: Galaxy A02 (SM-A022M)

Arvore para o A022M (MT6739, Android 11, firmware A022MUBS4BWL2), partindo da
do A022F e corrigida com os dados reais do aparelho. NAO TESTADA.

## Antes de compilar
1. `prebuilt/` ja esta preenchido (kernel, dtb.img, dtbo.img do recovery stock do A022M).
2. `recovery/root/` ja traz `init.recovery.mt6739.rc` (ajustado para USB configfs) e
   `init.recovery.samsung.rc`, ambos a partir do recovery stock do A022M.
3. Conferir o `TODO` restante do `BoardConfig.mk` (brilho da tela).

## Compilar
Actions > "Build TWRP A022M" > Run workflow. O resultado fica em Artifacts
(`recovery.img` e `recovery.tar` para o Odin). O job falha se o recovery.img
passar de 25165824 bytes (24 MiB).
