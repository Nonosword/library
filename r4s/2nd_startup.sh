rm -f *.deb

docker rmi `docker images -q`
sudo rm -rf /usr/share/dotnet /etc/mysql /etc/php /etc/apt/sources.list.d /usr/local/lib/android
sudo -E apt-get -y purge azure-cli ghc* zulu* hhvm llvm* firefox google* dotnet* powershell openjdk* adoptopenjdk* mysql* php* mongodb* dotnet* moby* snapd* || true
sudo -E apt-get update
sudo -E apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch python3 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs gcc-multilib g++-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler antlr3 gperf swig
sudo -E apt-get -y autoremove --purge
sudo -E apt-get clean
df -h

sudo apt-get update
sudo apt-get upgrade

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

make -j8 download V=s
make -j1 V=s

pip install simplefileserver
sudo ufw allow 8080
# simplefileserver

# reboot
