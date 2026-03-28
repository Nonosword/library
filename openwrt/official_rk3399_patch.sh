perl -pi.bak -e 's/^  ifeq \(\$\(HOST_ARCH\),aarch64\)$/  ifneq \(\$\(filter aarch64 arm64,\$\(HOST_ARCH\)\),\)/' package/boot/arm-trusted-firmware-rockchip/Makefile
