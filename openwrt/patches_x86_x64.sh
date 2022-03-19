sed -i 's/192.168.1.1/192.168.2.1/' package/base-files/files/bin/config_generate

# luci-app-jd-dailybonus
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/lean/luci-app-jd-dailybonus
echo "CONFIG_PACKAGE_luci-app-jd-dailybonus=y" >> .config

# fix adguardhome luci
sed -i 's/AdGuardHome/adguardhome/g' package/feeds/small8/luci-app-adguardhome/Makefile
cat package/feeds/small8/luci-app-adguardhome/Makefile
