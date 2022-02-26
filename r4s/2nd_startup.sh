rm -f *.deb

sudo apt-get update
sudo apt-get upgrade
sudo apt-get -y autoremove --purge
sudo apt-get clean

echo "ubuntu ALL=(ALL:ALL) ALL">>/etc/sudoers
echo "ubuntu ALL=(ALL) NOPASSWD:ALL">>/etc/sudoers
su ubuntu
cd ~

git clone https://github.com/coolsnowwolf/lede /home/ubuntu/lede

cd /home/ubuntu/lede
wget https://raw.githubusercontent.com/Nonosword/library/main/r4s/extra_feeds
cat extra_feeds >> feeds.conf.default

./scripts/feeds update -a
./scripts/feeds install -a

wget https://raw.githubusercontent.com/Nonosword/library/main/r4s/patches.sh
chmod +x ./patches.sh
./patches.sh

wget https://raw.githubusercontent.com/Nonosword/library/main/r4s/def_config
# wget https://raw.githubusercontent.com/Nonosword/library/main/r4s/extra_config
# cat extra_config >> def_config
cat def_config > .config

# make -j8 download V=s
# make -j1 V=s

# simplefileserver
