#!/bin/sh

echo 正在安装编译所需依赖. . .

apt -y install cmake gcc g++ make libncurses5-dev libssl-dev libsodium-dev libreadline-dev zlib1g-dev git libmnl-dev libnftnl-dev linux-headers-amd64

echo 正在下载项目文件. . .

cd root

git clone https://github.com/Chion82/netfilter-full-cone-nat/tree/feature/ipv6/ netfilter-full-cone-nat

echo 编译Fullcone模块. . .

cd ~/netfilter-full-cone-nat

make

modprobe nf_nat

insmod xt_FULLCONENAT.ko

echo 编译iptables. . .

git clone git://git.netfilter.org/iptables.git

cp ~/netfilter-full-cone-nat/libipt_FULLCONENAT.c ~/iptables/extensions/

cp ~/netfilter-full-cone-nat/libip6t_FULLCONENAT.c ~/iptables/extensions/

cd ~/iptables

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

echo 正在添加Fullcone规则. . .

iptables -t nat -A POSTROUTING -o eth0 -j FULLCONENAT

iptables -t nat -A PREROUTING -i eth0 -j FULLCONENAT

ip6tables -t nat -A POSTROUTING -o eth0 -j FULLCONENAT

ip6tables -t nat -A PREROUTING -i eth0 -j FULLCONENAT

exit 0
