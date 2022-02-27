su ubuntu
git clone https://github.com/coolsnowwolf/lede /home/ubuntu/lede
cd /home/ubuntu/lede

wget https://raw.githubusercontent.com/Nonosword/library/main/r4s/extra_feeds
cat extra_feeds >> feeds.conf.default
./scripts/feeds update -a
./scripts/feeds install -a

wget https://raw.githubusercontent.com/Nonosword/library/main/r4s/r4s_load.seed
cat r4s_load.seed > .config
wget https://raw.githubusercontent.com/Nonosword/library/main/r4s/patches.sh
chmod +x ./patches.sh
./patches.sh

sed -i 's/^[ \t]*//g' ./.config
make defconfig

make download -j8 || make download -j1 V=s
rm -rf $(find ./dl/ -size -1024c)
df -h

make -j$(nproc) || make -j1 V=s
echo "======================="
echo "Space usage:"
echo "======================="
df -h
echo "======================="
du -h ./ --max-depth=1
du -h /mnt/openwrt/ --max-depth=1 || true

# simplefileserver
