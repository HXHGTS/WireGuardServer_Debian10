## 海外服务器(仅支持Debian10)

### 安装前运行

```
apt update && apt upgrade -y && apt dist-upgrade -y && reboot
```

### 普通安装:

```
apt install -y build-essential wget && wget https://raw.githubusercontent.com/HXHGTS/WireGuardServer_Debian10/main/WireGuard.c -O WireGuard.c && chmod +x WireGuard.c && gcc -o WireGuard WireGuard.c && chmod +x WireGuard && ./WireGuard
```

### 支持FULLCONE:

```
apt install -y build-essential wget && wget https://raw.githubusercontent.com/HXHGTS/WireGuardServer_Debian10/main/WireGuard_FullCone.c -O WireGuard.c && chmod +x WireGuard.c && gcc -o WireGuard WireGuard.c && chmod +x WireGuard && ./WireGuard
```

第一次点击安装后会自动升级系统内核并触发重启，重启后输入

```
./WireGuard
```

并选1继续安装

[返回](./README.md)
