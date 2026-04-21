#!/usr/bin/env bash
set -e

sed -i 's|192.168.1.1|192.168.100.1|' package/base-files/files/bin/config_generate
sed -i 's|Openwrt|Devvvvvice_Mainnet|' package/base-files/files/bin/config_generate
sed -i 's|OpenWrt|Devvvvvice_Mainnet|' package/base-files/files/bin/config_generate
sed -i "s|log_size='64'|log_size='1024'|" package/base-files/files/bin/config_generate

mkdir -p feeds/luci/modules/luci-base/root/usr/share/luci/menu.d

cat > feeds/luci/modules/luci-base/root/usr/share/luci/menu.d/luci-custom-groups.json <<'EOF'
{
	"admin/nas": {
		"title": "NAS",
		"order": 44,
		"action": {
			"type": "firstchild"
		}
	},
	"admin/vpn": {
		"title": "VPN",
		"order": 45,
		"action": {
			"type": "firstchild"
		}
	},
	"admin/nlbw": {
		"title": "Bandwidth_Monitor",
		"order": 46,
		"action": {
			"type": "firstchild"
		}
	}
}
EOF

ARIA2_JSON="feeds/luci/applications/luci-app-aria2/root/usr/share/luci/menu.d/luci-app-aria2.json"
HDIDLE_JSON="feeds/luci/applications/luci-app-hd-idle/root/usr/share/luci/menu.d/luci-app-hd-idle.json"
SAMBA4_JSON="feeds/luci/applications/luci-app-samba4/root/usr/share/luci/menu.d/luci-app-samba4.json"
NLBW_JSON="feeds/luci/applications/luci-app-nlbwmon/root/usr/share/luci/menu.d/luci-app-nlbwmon.json"
STATUS_JSON="feeds/luci/modules/luci-mod-status/root/usr/share/luci/menu.d/luci-mod-status.json"

if [ -f "$ARIA2_JSON" ]; then
  sed -i 's#"admin/services/aria2"#"admin/nas/aria2"#g' "$ARIA2_JSON"
  sed -i 's#"admin/services/aria2/config"#"admin/nas/aria2/config"#g' "$ARIA2_JSON"
  sed -i 's#"admin/services/aria2/files"#"admin/nas/aria2/files"#g' "$ARIA2_JSON"
  sed -i 's#"admin/services/aria2/log"#"admin/nas/aria2/log"#g' "$ARIA2_JSON"
fi

if [ -f "$HDIDLE_JSON" ]; then
  sed -i 's#"admin/services/hd_idle"#"admin/nas/hd_idle"#g' "$HDIDLE_JSON"
fi

if [ -f "$SAMBA4_JSON" ]; then
  sed -i 's#"admin/services/samba4"#"admin/nas/samba4"#g' "$SAMBA4_JSON"
fi

if [ -f "$NLBW_JSON" ]; then
  sed -i 's#"admin/services/nlbw"#"admin/nlbw/nlbw"#g' "$NLBW_JSON"
  sed -i 's#"admin/services/nlbw/display"#"admin/nlbw/nlbw/display"#g' "$NLBW_JSON"
  sed -i 's#"admin/services/nlbw/config"#"admin/nlbw/nlbw/config"#g' "$NLBW_JSON"
  sed -i 's#"admin/services/nlbw/backup"#"admin/nlbw/nlbw/backup"#g' "$NLBW_JSON"
  sed -i 's#"path": "admin/services/nlbw/display"#"path": "admin/nlbw/nlbw/display"#g' "$NLBW_JSON"
fi

if [ -f "$STATUS_JSON" ]; then
  sed -i 's#"admin/status/realtime"#"admin/nlbw/realtime"#g' "$STATUS_JSON"
  sed -i 's#"admin/status/realtime/load"#"admin/nlbw/realtime/load"#g' "$STATUS_JSON"
  sed -i 's#"admin/status/realtime/bandwidth"#"admin/nlbw/realtime/bandwidth"#g' "$STATUS_JSON"
  sed -i 's#"admin/status/realtime/wireless"#"admin/nlbw/realtime/wireless"#g' "$STATUS_JSON"
  sed -i 's#"admin/status/realtime/connections"#"admin/nlbw/realtime/connections"#g' "$STATUS_JSON"
  sed -i 's#"path": "admin/status/realtime/load"#"path": "admin/nlbw/realtime/load"#g' "$STATUS_JSON"
fi

NETDATA_LUA=""
if [ -f package/feeds/small_feeds/luci-app-netdata/luasrc/controller/netdata.lua ]; then
  NETDATA_LUA="package/feeds/small_feeds/luci-app-netdata/luasrc/controller/netdata.lua"
elif [ -f feeds/small_feeds/packages/luci-app-netdata/luasrc/controller/netdata.lua ]; then
  NETDATA_LUA="feeds/small_feeds/packages/luci-app-netdata/luasrc/controller/netdata.lua"
fi

if [ -n "$NETDATA_LUA" ]; then
  sed -i '/pidof netdata > \/dev\/null/,+2d' "$NETDATA_LUA"
  sed -i 's#{"admin", "system", "netdata"}#{"admin", "nlbw", "netdata"}#g' "$NETDATA_LUA"
fi

DISKMAN_LUA=""
if [ -f package/feeds/small_feeds/luci-app-diskman/luasrc/controller/diskman.lua ]; then
  DISKMAN_LUA="package/feeds/small_feeds/luci-app-diskman/luasrc/controller/diskman.lua"
elif [ -f feeds/small_feeds/packages/luci-app-diskman/luasrc/controller/diskman.lua ]; then
  DISKMAN_LUA="feeds/small_feeds/packages/luci-app-diskman/luasrc/controller/diskman.lua"
fi

if [ -n "$DISKMAN_LUA" ]; then
  sed -i 's#alias("admin", "system", "diskman", "disks")#alias("admin", "nas", "diskman", "disks")#g' "$DISKMAN_LUA"
  sed -i 's#{"admin", "system", "diskman"}#{"admin", "nas", "diskman"}#g' "$DISKMAN_LUA"
  sed -i 's#{"admin", "system", "diskman", "disks"}#{"admin", "nas", "diskman", "disks"}#g' "$DISKMAN_LUA"
  sed -i 's#{"admin", "system", "diskman", "partition"}#{"admin", "nas", "diskman", "partition"}#g' "$DISKMAN_LUA"
  sed -i 's#{"admin", "system", "diskman", "btrfs"}#{"admin", "nas", "diskman", "btrfs"}#g' "$DISKMAN_LUA"
  sed -i 's#{"admin", "system", "diskman", "format_partition"}#{"admin", "nas", "diskman", "format_partition"}#g' "$DISKMAN_LUA"
  sed -i 's#{"admin", "system", "diskman", "get_disk_info"}#{"admin", "nas", "diskman", "get_disk_info"}#g' "$DISKMAN_LUA"
  sed -i 's#{"admin", "system", "diskman", "mk_p_table"}#{"admin", "nas", "diskman", "mk_p_table"}#g' "$DISKMAN_LUA"
  sed -i 's#{"admin", "system", "diskman", "smartdetail"}#{"admin", "nas", "diskman", "smartdetail"}#g' "$DISKMAN_LUA"
  sed -i 's#{"admin", "system", "diskman", "smartattr"}#{"admin", "nas", "diskman", "smartattr"}#g' "$DISKMAN_LUA"
fi

VSFTPD_LUA=""
if [ -f package/feeds/small_feeds/luci-app-vsftpd/luasrc/controller/vsftpd.lua ]; then
  VSFTPD_LUA="package/feeds/small_feeds/luci-app-vsftpd/luasrc/controller/vsftpd.lua"
elif [ -f feeds/small_feeds/packages/luci-app-vsftpd/luasrc/controller/vsftpd.lua ]; then
  VSFTPD_LUA="feeds/small_feeds/packages/luci-app-vsftpd/luasrc/controller/vsftpd.lua"
fi

if [ -n "$VSFTPD_LUA" ]; then
  sed -i 's#{"admin", "services", "nas", "vsftpd"}#{"admin", "nas", "vsftpd"}#g' "$VSFTPD_LUA"
  sed -i 's#{"admin", "services", "nas", "vsftpd", "general"}#{"admin", "nas", "vsftpd", "general"}#g' "$VSFTPD_LUA"
  sed -i 's#{"admin", "services", "nas", "vsftpd", "users"}#{"admin", "nas", "vsftpd", "users"}#g' "$VSFTPD_LUA"
  sed -i 's#{"admin", "services", "nas", "vsftpd", "anonymous"}#{"admin", "nas", "vsftpd", "anonymous"}#g' "$VSFTPD_LUA"
  sed -i 's#{"admin", "services", "nas", "vsftpd", "log"}#{"admin", "nas", "vsftpd", "log"}#g' "$VSFTPD_LUA"
  sed -i 's#{"admin", "services", "nas", "vsftpd", "item"}#{"admin", "nas", "vsftpd", "item"}#g' "$VSFTPD_LUA"
fi

PASSWALL2_LUA=""
if [ -f package/feeds/passwall2/luci-app-passwall2/luasrc/controller/passwall2.lua ]; then
  PASSWALL2_LUA="package/feeds/passwall2/luci-app-passwall2/luasrc/controller/passwall2.lua"
elif [ -f feeds/passwall2/luci-app-passwall2/luasrc/controller/passwall2.lua ]; then
  PASSWALL2_LUA="feeds/passwall2/luci-app-passwall2/luasrc/controller/passwall2.lua"
fi

if [ -n "$PASSWALL2_LUA" ]; then
  sed -i 's#{"admin", "services", appname#{"admin", "vpn", appname#g' "$PASSWALL2_LUA"
  sed -i 's#alias("admin", "services", appname#alias("admin", "vpn", appname#g' "$PASSWALL2_LUA"
fi

TAILSCALE_JSON=""
for candidate in \
  package/feeds/packages/luci-app-tailscale-community/root/usr/share/luci/menu.d/luci-app-tailscale-community.json \
  package/feeds/packages/luci-app-tailscale/root/usr/share/luci/menu.d/luci-app-tailscale.json \
  package/feeds/packages/luci-app-tailscale/root/usr/share/luci/menu.d/luci-app-tailscale-community.json \
  feeds/packages/net/tailscale/files/luci-app-tailscale/root/usr/share/luci/menu.d/luci-app-tailscale.json \
  feeds/packages/net/tailscale/files/luci-app-tailscale/root/usr/share/luci/menu.d/luci-app-tailscale-community.json
do
  if [ -f "$candidate" ]; then
    TAILSCALE_JSON="$candidate"
    break
  fi
done

if [ -n "$TAILSCALE_JSON" ]; then
  sed -i 's#"admin/services/tailscale"#"admin/vpn/tailscale"#g' "$TAILSCALE_JSON"
fi
