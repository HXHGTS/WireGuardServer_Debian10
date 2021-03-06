#!/bin/sh

echo 正在安装编译所需依赖. . .

apt -y install cmake gcc g++ make libncurses5-dev libssl-dev libsodium-dev libreadline-dev zlib1g-dev git pkg-config

echo 正在下载项目文件. . .

cd /root

git clone https://github.com/Chion82/netfilter-full-cone-nat netfilter-full-cone-nat

wget https://www.netfilter.org/pub/libmnl/libmnl-1.0.5.tar.bz2 -O libmnl-1.0.5.tar.bz2

wget https://www.netfilter.org/pub/libnftnl/libnftnl-1.2.2.tar.bz2 -O libnftnl-1.2.2.tar.bz2

wget https://www.netfilter.org/projects/iptables/files/iptables-1.8.8.tar.bz2 -O iptables-1.8.8.tar.bz2

echo 正在解压项目文件. . .

tar -jxvf libmnl-1.0.5.tar.bz2

tar -jxvf libnftnl-1.2.2.tar.bz2

tar -jxvf iptables-1.8.8.tar.bz2

echo 正在删除项目文件. . .

rm -f libmnl-1.0.5.tar.bz2

rm -f libnftnl-1.2.2.tar.bz2

rm -f iptables-1.8.8.tar.bz2

echo 编译安装libmnl. . .

cd ~/libmnl-1.0.5

./configure

make

make install

echo 编译安装libnftnl. . .

cd ~/libnftnl-1.2.2

./configure

make

make install

echo 编译Fullcone模块. . .

cd ~/netfilter-full-cone-nat

make

modprobe nf_nat

insmod xt_FULLCONENAT.ko

echo 编译iptables. . .

cd /root

cp ~/netfilter-full-cone-nat/libipt_FULLCONENAT.c ~/iptables-1.8.8/extensions/

cp ~/netfilter-full-cone-nat/libip6t_FULLCONENAT.c ~/iptables-1.8.8/extensions/

cd ~/iptables-1.8.8

ln -sfv /usr/sbin/xtables-multi /usr/bin/iptables-xml

PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

export PKG_CONFIG_PATH

./configure

make

make install

echo 部署Fullcone模块. . .

cp ~/netfilter-full-cone-nat/xt_FULLCONENAT.ko  /lib/modules/$(uname -r)/

depmod

echo "modprobe xt_FULLCONENAT" >> /etc/modules-load.d/fullconenat.conf

echo 下方有输出则安装完成:

echo -----------------------------------------------------

lsmod | grep xt_FULLCONENAT

echo -----------------------------------------------------

exit 0
