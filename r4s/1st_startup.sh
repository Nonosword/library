########## pre config ##########

# echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
# echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
# sed -i "s|#AuthorizedKeysFile|AuthorizedKeysFile|g" /etc/ssh/sshd_config
sed -i "s|PasswordAuthentication yes|PasswordAuthentication no|g" /etc/ssh/sshd_config
sudo /etc/init.d/ssh restart

docker rmi `docker images -q`
sudo rm -rf /usr/share/dotnet /etc/mysql /etc/php /etc/apt/sources.list.d /usr/local/lib/android
sudo apt-get -y purge azure-cli ghc* zulu* hhvm llvm* firefox google* dotnet* powershell openjdk* adoptopenjdk* mysql* php* mongodb* dotnet* moby* snapd* || true
sudo apt-get update
sudo apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch python3 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs gcc-multilib g++-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler antlr3 gperf swig libtinfo5
sudo apt-get -y autoremove --purge
sudo apt-get clean
df -h

pip install simplefileserver
sudo ufw allow 8080

echo "ubuntu ALL=(ALL:ALL) ALL">>/etc/sudoers
echo "ubuntu ALL=(ALL) NOPASSWD:ALL">>/etc/sudoers

# sudo apt install libc6 debconf
# wget http://mirrors.kernel.org/ubuntu/pool/main/o/openssl/libssl3_3.0.1-0ubuntu1_amd64.deb
# sudo dpkg -i libssl3_3.0.1-0ubuntu1_amd64.deb
# sudo apt -f install
# wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.15.25/amd64/linux-headers-5.15.25-051525-generic_5.15.25-051525.202202231324_amd64.deb
# wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.15.25/amd64/linux-headers-5.15.25-051525_5.15.25-051525.202202231324_all.deb
# wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.15.25/amd64/linux-image-unsigned-5.15.25-051525-generic_5.15.25-051525.202202231324_amd64.deb
# wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.15.25/amd64/linux-modules-5.15.25-051525-generic_5.15.25-051525.202202231324_amd64.deb
# sudo dpkg -i *.deb
# rm -f *.deb

# reboot

########## build on reboot ##########

cat > 2nd_screen.sh << "EOF"
screen_name1="buildr4s"
cmd1="wget https://raw.githubusercontent.com/Nonosword/library/main/r4s/2nd_startup.sh -O 2nd_startup.sh"
cmd2="chmod +x 2nd_startup.sh"
cmd3="./2nd_startup.sh"
screen -dmS $screen_name1
screen -x -S $screen_name1 -p 0 -X stuff "$cmd1"
screen -x -S $screen_name1 -p 0 -X stuff '\n'
screen -x -S $screen_name1 -p 0 -X stuff "$cmd2"
screen -x -S $screen_name1 -p 0 -X stuff '\n'
screen -x -S $screen_name1 -p 0 -X stuff "$cmd3"
screen -x -S $screen_name1 -p 0 -X stuff '\n'
EOF

chmod +x 2nd_screen.sh
echo "@reboot root bash ./2nd_screen.sh" >> /etc/crontab
