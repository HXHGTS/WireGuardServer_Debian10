#!/bin/sh

echo 正在安装内核. . .

apt install -y linux-image-$(uname -r)

echo 正在安装编译所需依赖. . .

apt -y install cmake gcc g++ make libncurses5-dev libssl-dev libsodium-dev libreadline-dev zlib1g-dev git pkg-config autoconf libtool m4 automake

echo 正在下载项目文件. . .

cd /root

git clone https://github.com/Chion82/netfilter-full-cone-nat netfilter-full-cone-nat

wget https://www.netfilter.org/pub/libmnl/libmnl-1.0.5.tar.bz2 -O libmnl-1.0.5.tar.bz2

wget https://www.netfilter.org/pub/libnftnl/libnftnl-1.2.5.tar.xz -O libnftnl-1.2.5.tar.xz

wget https://www.netfilter.org/projects/iptables/files/iptables-1.8.9.tar.xz -O iptables-1.8.9.tar.xz

echo 正在解压项目文件. . .

tar -jxvf libmnl-1.0.5.tar.bz2

tar -xf libnftnl-1.2.5.tar.xz

tar -xf iptables-1.8.9.tar.xz

echo 正在删除项目文件. . .

rm -f libmnl-1.0.5.tar.bz2

rm -f libnftnl-1.2.5.tar.xz

rm -f iptables-1.8.9.tar.xz

echo 编译安装libmnl. . .

cd ~/libmnl-1.0.5

./configure

make

make install

echo 编译安装libnftnl. . .

cd ~/libnftnl-1.2.5

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

cp -f ~/netfilter-full-cone-nat/libipt_FULLCONENAT.c ~/iptables-1.8.9/extensions/

cd ~/iptables-1.8.9

ln -sfv /usr/sbin/xtables-multi /usr/bin/iptables-xml

bash ~/iptables-1.8.9/autogen.sh

PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

export PKG_CONFIG_PATH

./configure

make

make install

echo 部署Fullcone模块. . .

cp -f ~/netfilter-full-cone-nat/xt_FULLCONENAT.ko /lib/modules/$(uname -r)/

depmod

echo "modprobe xt_FULLCONENAT" > /etc/modules-load.d/fullconenat.conf

echo 下方有输出则安装完成:

echo -----------------------------------------------------

lsmod | grep xt_FULLCONENAT

echo -----------------------------------------------------

exit 0
