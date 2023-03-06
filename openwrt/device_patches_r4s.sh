sed -i 's|Devvvvvice|R4S|' package/base-files/files/bin/config_generate

# change the voltage value for over-clock stablization
config_file_cpufreq=`find package/ -follow -type f -path '*/luci-app-cpufreq/root/etc/config/cpufreq'`
truncate -s-1 $config_file_cpufreq
echo -e "\toption governor0 'schedutil'" >> $config_file_cpufreq
echo -e "\toption minfreq0 '816000'" >> $config_file_cpufreq
echo -e "\toption maxfreq0 '1512000'\n" >> $config_file_cpufreq

# luci-app-jd-dailybonus
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/lean/luci-app-jd-dailybonus
echo "CONFIG_PACKAGE_luci-app-jd-dailybonus=y" >> .config
