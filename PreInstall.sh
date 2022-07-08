#!/bin/sh

apt install -y build-essential net-tools iproute2 wget

echo "正在优化大文件读写性能. . ."

echo '* soft nofile 65536' > /etc/security/limits.conf

echo '* hard nofile 65536' >> /etc/security/limits.conf

echo 'root soft nofile 65536 >> /etc/security/limits.conf

echo 'root hard nofile 65536 >> /etc/security/limits.conf

echo '* soft memlock unlimited >> /etc/security/limits.conf

echo '* hard memlock unlimited >> /etc/security/limits.conf

echo "优化完成!"

exit 0
