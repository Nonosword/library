sed -i 's|192.168.1.1|192.168.2.1|' package/base-files/files/bin/config_generate
sed -i "s|log_size='64'|log_size='1024'|" package/base-files/files/bin/config_generate
