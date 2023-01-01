#!/bin/sh

apt install -y build-essential net-tools iproute2 wget

echo "正在配置IPV4转发. . ."

echo 'net.ipv4.ip_forward = 1' > /etc/sysctl.conf

echo 'net.ipv6.conf.all.disable_ipv6 = 1' >> /etc/sysctl.conf

echo 'net.ipv6.conf.default.disable_ipv6 = 1' >> /etc/sysctl.conf

echo 'net.ipv6.conf.lo.disable_ipv6 = 1' >> /etc/sysctl.conf

echo 'net.ipv6.conf.eth0.disable_ipv6 = 1' >> /etc/sysctl.conf

echo "正在开启BBR. . ."

echo 'net.core.default_qdisc = fq' >> /etc/sysctl.conf

echo 'net.ipv4.tcp_congestion_control = bbr' >> /etc/sysctl.conf

sysctl -p

echo "优化完成!"

exit 0
