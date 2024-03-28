sed -i 's|192.168.1.1|192.168.100.1|' package/base-files/files/bin/config_generate
sed -i 's|Openwrt|Devvvvvice_Mainnet|' package/base-files/files/bin/config_generate
sed -i 's|OpenWrt|Devvvvvice_Mainnet|' package/base-files/files/bin/config_generate
sed -i "s|log_size='64'|log_size='1024'|" package/base-files/files/bin/config_generate
