echo "net.ipv4.ip_forward=0" >> /etc/sysctl.conf
echo "net.ipv6.conf.all.forwarding=0" >> /etc/sysctl.conf
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sudo sysctl -p
# check
sudo sysctl net.ipv4.tcp_available_congestion_control
sudo sysctl -n net.ipv4.tcp_congestion_control
lsmod | grep bbr

acme.sh --upgrade --auto-upgrade
acme.sh --set-default-ca  --server zerossl

sed -i '/bbr-part2/d' /var/spool/cron/root
service crond restart
reboot
