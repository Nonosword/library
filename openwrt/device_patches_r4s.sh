if sed --version >/dev/null 2>&1; then
  sed -i 's|Devvvvvice|R4S|' package/base-files/files/bin/config_generate
else
  sed -i '' 's|Devvvvvice|R4S|' package/base-files/files/bin/config_generate
fi

config_file_cpufreq="$(find package/ -follow -type f -path '*/luci-app-cpufreq/root/etc/config/cpufreq' | head -n 1)"

if [ -n "$config_file_cpufreq" ] && [ -f "$config_file_cpufreq" ]; then
  truncate -s-1 "$config_file_cpufreq"
  printf "\toption governor0 'schedutil'\n" >> "$config_file_cpufreq"
  printf "\toption minfreq0 '816000'\n" >> "$config_file_cpufreq"
  printf "\toption maxfreq0 '1512000'\n\n" >> "$config_file_cpufreq"
fi

# luci-app-jd-dailybonus
# git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/lean/luci-app-jd-dailybonus
# echo "CONFIG_PACKAGE_luci-app-jd-dailybonus=y" >> .config
