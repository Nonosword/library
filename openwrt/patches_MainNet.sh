#!/usr/bin/env bash

if sed --version >/dev/null 2>&1; then
  SED_INPLACE=(-i)
else
  SED_INPLACE=(-i '')
fi

sed "${SED_INPLACE[@]}" 's|192.168.1.1|192.168.100.1|' package/base-files/files/bin/config_generate
sed "${SED_INPLACE[@]}" 's|Openwrt|Devvvvvice_Mainnet|' package/base-files/files/bin/config_generate
sed "${SED_INPLACE[@]}" 's|OpenWrt|Devvvvvice_Mainnet|' package/base-files/files/bin/config_generate
sed "${SED_INPLACE[@]}" "s|log_size='64'|log_size='1024'|" package/base-files/files/bin/config_generate
