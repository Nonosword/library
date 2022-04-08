sed -i 's|192.168.1.1|192.168.99.1|' package/base-files/files/bin/config_generate
sed -i 's|Openwrt|R4S_Subnet|' package/base-files/files/bin/config_generate
sed -i 's|OpenWrt|R4S_Subnet|' package/base-files/files/bin/config_generate
sed -i 's|log_size='64'|log_size='6400'|' package/base-files/files/bin/config_generate
