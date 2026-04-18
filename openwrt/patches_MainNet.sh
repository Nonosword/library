#!/usr/bin/env bash
set -e

sed -i 's|192.168.1.1|192.168.100.1|' package/base-files/files/bin/config_generate
sed -i 's|Openwrt|Devvvvvice_Mainnet|' package/base-files/files/bin/config_generate
sed -i 's|OpenWrt|Devvvvvice_Mainnet|' package/base-files/files/bin/config_generate
sed -i "s|log_size='64'|log_size='1024'|" package/base-files/files/bin/config_generate

mkdir -p feeds/luci/modules/luci-base/root/usr/share/luci/menu.d

cat > feeds/luci/modules/luci-base/root/usr/share/luci/menu.d/luci-services-nas.json <<'EOF'
{
	"admin/services/nas": {
		"title": "NAS",
		"order": 25,
		"action": {
			"type": "firstchild"
		}
	}
}
EOF

ARIA2_JSON="feeds/luci/applications/luci-app-aria2/root/usr/share/luci/menu.d/luci-app-aria2.json"
SAMBA4_JSON="feeds/luci/applications/luci-app-samba4/root/usr/share/luci/menu.d/luci-app-samba4.json"
HDIDLE_JSON="feeds/luci/applications/luci-app-hd-idle/root/usr/share/luci/menu.d/luci-app-hd-idle.json"

if [ -f "$ARIA2_JSON" ]; then
  sed -i 's#"admin/services/aria2"#"admin/services/nas/aria2"#g' "$ARIA2_JSON"
  sed -i 's#"admin/services/aria2/config"#"admin/services/nas/aria2/config"#g' "$ARIA2_JSON"
  sed -i 's#"admin/services/aria2/files"#"admin/services/nas/aria2/files"#g' "$ARIA2_JSON"
  sed -i 's#"admin/services/aria2/log"#"admin/services/nas/aria2/log"#g' "$ARIA2_JSON"
fi

if [ -f "$SAMBA4_JSON" ]; then
  sed -i 's#"admin/services/samba4"#"admin/services/nas/samba4"#g' "$SAMBA4_JSON"
fi

if [ -f "$HDIDLE_JSON" ]; then
  sed -i 's#"admin/services/hd_idle"#"admin/services/nas/hd_idle"#g' "$HDIDLE_JSON"
fi

VSFTPD_LUA=""
if [ -f package/feeds/small_feeds/luci-app-vsftpd/luasrc/controller/vsftpd.lua ]; then
  VSFTPD_LUA="package/feeds/small_feeds/luci-app-vsftpd/luasrc/controller/vsftpd.lua"
elif [ -f feeds/small_feeds/packages/luci-app-vsftpd/luasrc/controller/vsftpd.lua ]; then
  VSFTPD_LUA="feeds/small_feeds/packages/luci-app-vsftpd/luasrc/controller/vsftpd.lua"
fi

if [ -n "$VSFTPD_LUA" ]; then
  sed -i 's#{"admin", "nas", "vsftpd"}#{"admin", "services", "nas", "vsftpd"}#g' "$VSFTPD_LUA"
  sed -i 's#{"admin", "nas", "vsftpd", "general"}#{"admin", "services", "nas", "vsftpd", "general"}#g' "$VSFTPD_LUA"
  sed -i 's#{"admin", "nas", "vsftpd", "users"}#{"admin", "services", "nas", "vsftpd", "users"}#g' "$VSFTPD_LUA"
  sed -i 's#{"admin", "nas", "vsftpd", "anonymous"}#{"admin", "services", "nas", "vsftpd", "anonymous"}#g' "$VSFTPD_LUA"
  sed -i 's#{"admin", "nas", "vsftpd", "log"}#{"admin", "services", "nas", "vsftpd", "log"}#g' "$VSFTPD_LUA"
  sed -i 's#{"admin", "nas", "vsftpd", "item"}#{"admin", "services", "nas", "vsftpd", "item"}#g' "$VSFTPD_LUA"
fi
