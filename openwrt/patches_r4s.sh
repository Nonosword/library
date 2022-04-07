
# swap the network adapter driver to r8168 to gain better performance for r4s
# sed -i 's/r8169/r8168/' target/linux/rockchip/image/armv8.mk

# change the voltage value for over-clock stablization
# sed -i 's/1400000/1450000/' target/linux/rockchip/patches-5.10/991-arm64-dts-rockchip-add-more-cpu-operating-points-for.patch
# config_file_cpufreq=`find package/ -follow -type f -path '*/luci-app-cpufreq/root/etc/config/cpufreq'`
# truncate -s-1 $config_file_cpufreq
# echo -e "\toption governor0 'schedutil'" >> $config_file_cpufreq
# echo -e "\toption minfreq0 '816000'" >> $config_file_cpufreq
# echo -e "\toption maxfreq0 '1512000'\n" >> $config_file_cpufreq

# git clean -f -d target/linux/rockchip
# enable the gpu for device 'r2s'|'r2c'|'r4s'|'r1p'
# wget https://github.com/coolsnowwolf/lede/raw/757e42d70727fe6b937bb31794a9ad4f5ce98081/target/linux/rockchip/config-default -NP # target/linux/rockchip/
# wget https://github.com/coolsnowwolf/lede/commit/f341ef96fe4b509a728ba1281281da96bac23673.patch
# sed -i 's/config-5.4/config-5.10/g' f341ef96fe4b509a728ba1281281da96bac23673.patch
# git apply f341ef96fe4b509a728ba1281281da96bac23673.patch
# rm f341ef96fe4b509a728ba1281281da96bac23673.patch

# luci-app-jd-dailybonus
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/lean/luci-app-jd-dailybonus
echo "CONFIG_PACKAGE_luci-app-jd-dailybonus=y" >> .config

# fix small8 adguardhome luci
# rm -rf feeds/small8/adguardhome
# sed -i 's/AdGuardHome/adguardhome/g' feeds/small8/luci-app-adguardhome/Makefile
# sed -i 's/AdGuardHome/adguardhome/g' package/feeds/small8/luci-app-adguardhome/Makefile
# sed -i 's/AdGuardHome/adguardhome/g' package/feeds/small8/luci-app-adguardhome/root/etc/config/AdGuardHome
# cat feeds/small8/luci-app-adguardhome/Makefile
