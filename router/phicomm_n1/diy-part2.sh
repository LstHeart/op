#!/bin/bash
#========================================================================================================================
# https://github.com/ophub/op
# Description: Automatically Build OpenWrt for Phicomm-N1
# Function: Diy script (After Update feeds, Modify the default IP, hostname, theme, add/remove software packages, etc.)
# Copyright (C) 2020 https://github.com/P3TERX/Actions-OpenWrt
# Copyright (C) 2020 https://github.com/ophub/op
# 此脚本用于在 update feeds 之后的相关修改,主要用于修改.config文件,添加或删除luci-app以及修改默认网关或主题等
# 此脚本运行于编译的根目录
#========================================================================================================================
echo "开始执行脚本2,当前目录为:$(pwd)"
# cd openwrt
# Modify default IP（FROM 192.168.1.1 CHANGE TO 192.168.31.8）
# 修改默认网关 192.168.1.1 --> 192.168.31.8
sed -i 's/ipaddr:-"192.168.1.1"/ipaddr:-"192.168.31.8"/g' package/base-files/files/bin/config_generate
# Modify default theme（FROM uci-theme-bootstrap CHANGE TO luci-theme-material）
# sed -i 's/luci-theme-bootstrap/luci-theme-material/g' ./feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' ./feeds/luci/collections/luci/Makefile
# Modify default root's password（FROM 'password'[$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.] CHANGE TO 'your password'）
# sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' package/base-files/files/etc/shadow
# sed -i 's#openwrt.proxy.ustclug.org#mirrors.bfsu.edu.cn\\/openwrt#' package/lean/default-settings/files/zzz-default-settings
zzz="package/lean/default-settings/files/zzz-default-settings"
sed -i 's/samba/samba4/' $zzz
sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' package/lean/luci-app-cpufreq/Makefile

# Mydiy-luci-app-and-theme（use to /.config luci-app&theme）
# 修改.config中的app配置或主题配置
# ==========luci-app==========
# 修改插件配置
cat >.config <<-EOF
## target
# 执行make defconfig命令之前,一定要指定编译平台
CONFIG_TARGET_armvirt=y
CONFIG_TARGET_armvirt_64=y
CONFIG_TARGET_armvirt_64_Default=y
# 新增或打开需要添加的插件(luci-app)
# DNS防污染插件
CONFIG_PACKAGE_luci-app-smartdns=y
# 网络端口转发插件
CONFIG_PACKAGE_socat=y
CONFIG_SOCAT_SSL=y
CONFIG_PACKAGE_luci-app-socat=y
CONFIG_PACKAGE_luci-i18n-socat-zh-cn=y
# 京东签到插件
CONFIG_PACKAGE_luci-app-jd-dailybonus=y
# 甜糖星愿自动收集插件
# CONFIG_PACKAGE_luci-app-ttnode=y
# CONFIG_PACKAGE_luci-app-ttnode is not set
# 网络唤醒wol
# CONFIG_DEFAULT_luci-app-wol is not set
CONFIG_PACKAGE_wol=y
CONFIG_PACKAGE_luci-app-wol=y
CONFIG_PACKAGE_luci-i18n-wol-en=y
CONFIG_PACKAGE_luci-i18n-wol-zh-cn=y
CONFIG_PACKAGE_etherwake=y
# docker界面管理
CONFIG_PACKAGE_luci-lib-docker=y
CONFIG_PACKAGE_luci-app-dockerman=y
# 内网穿透Zerotier
CONFIG_PACKAGE_zerotier=y
CONFIG_PACKAGE_luci-app-zerotier=y
CONFIG_PACKAGE_luci-i18n-zerotier-zh-cn=y
# CPU调频
CONFIG_PACKAGE_luci-app-cpufreq=y
CONFIG_PACKAGE_luci-i18n-cpufreq-zh_Hans=y
# CONFIG_DEFAULT_luci-app-cpufreq is not set
# samba4
CONFIG_PACKAGE_luci-app-samba4=y

# ---关闭不需要的插件---
# 解锁网易云音乐
# CONFIG_DEFAULT_luci-app-unblockmusic is not set
# CONFIG_UnblockNeteaseMusic_Go is not set
# CONFIG_UnblockNeteaseMusic_NodeJS is not set
# CONFIG_PACKAGE_luci-app-unblockmusic is not set
# 微力同步插件
# CONFIG_PACKAGE_luci-app-verysync is not set
# Server酱推送插件
# CONFIG_PACKAGE_luci-app-serverchan is not set
# 多播插件
# CONFIG_PACKAGE_luci-app-syncdial is not set
# CONFIG_PACKAGE_luci-app-mwan3 is not set
# CONFIG_PACKAGE_luci-app-mwan3helper is not set
# 内网穿透frpc
# CONFIG_PACKAGE_luci-app-frpc is not set
# CONFIG_PACKAGE_luci-app-frps is not set
# 带宽监控
# CONFIG_PACKAGE_luci-app-nlbwmon is not set
# 查看各终端实时流量网速的插件,依赖nlbwmon
# CONFIG_PACKAGE_luci-app-wrtbwmon=y

# ==========luci-theme==========
# 修改主题配置
# CONFIG_PACKAGE_luci-theme-bootstrap is not set
CONFIG_PACKAGE_luci-theme-argon=y
CONFIG_PACKAGE_luci-app-argon-config=y
EOF