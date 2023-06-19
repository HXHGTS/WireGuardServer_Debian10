#!/bin/sh

apt install -y build-essential net-tools iproute2 wget

echo "正在配置IPV4转发. . ."

echo 'net.ipv4.ip_forward = 1' > /etc/sysctl.conf

sysctl -p

echo "优化完成!"

exit 0
