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
# 删除default包
sed -i 's/\bluci-app-.*\b//g' ./include/target.mk
# sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' package/lean/luci-app-cpufreq/Makefile

# Mydiy-luci-app-and-theme（use to /.config luci-app&theme）
# 修改.config中的app配置或主题配置
# ==========luci-app==========
# 项目中.config文件只添加了最基本的luci-app插件,此处添加自己需要的插件
cat >>.config <<-EOF
# ==========luci app add==========
# DNS防污染插件
CONFIG_PACKAGE_luci-app-smartdns=m

# 网络端口转发插件
CONFIG_PACKAGE_socat=y
CONFIG_SOCAT_SSL=y
CONFIG_PACKAGE_luci-app-socat=m
CONFIG_PACKAGE_luci-i18n-socat-zh-cn=y

# 京东签到插件
CONFIG_PACKAGE_luci-app-jd-dailybonus=y

# 甜糖星愿自动收集插件
CONFIG_PACKAGE_luci-app-ttnode=y

# 网络唤醒wol
CONFIG_PACKAGE_wol=y
CONFIG_PACKAGE_etherwake=y
CONFIG_PACKAGE_luci-app-wol=m
CONFIG_PACKAGE_luci-i18n-wol-en=y
CONFIG_PACKAGE_luci-i18n-wol-zh-cn=y

# docker界面管理
CONFIG_PACKAGE_luci-lib-docker=y
CONFIG_PACKAGE_luci-app-dockerman=y

# 内网穿透Zerotier
CONFIG_PACKAGE_zerotier=y
CONFIG_PACKAGE_luci-app-zerotier=m
CONFIG_PACKAGE_luci-i18n-zerotier-zh-cn=y

# CPU调频
CONFIG_PACKAGE_luci-app-cpufreq=m
CONFIG_PACKAGE_luci-i18n-cpufreq-zh_Hans=y
# 网络实时监控图形界面
CONFIG_PACKAGE_luci-app-netdata=m

# 网络共享samba4
CONFIG_PACKAGE_luci-app-samba4=m
# usb打印
CONFIG_PACKAGE_kmod-usb-printer=m

# ==========luci app remove==========
# 解锁网易云音乐
# CONFIG_UnblockNeteaseMusic_Go is not set
CONFIG_UnblockNeteaseMusic_NodeJS=y
CONFIG_PACKAGE_luci-app-unblockmusic=m

# 微力同步插件
# CONFIG_PACKAGE_luci-app-verysync is not set

# Server酱推送插件
# CONFIG_PACKAGE_luci-app-serverchan is not set

# 多播插件
# CONFIG_PACKAGE_luci-app-syncdial is not set
# MWAN负载均衡,MWAN3分流助手
# CONFIG_PACKAGE_luci-app-mwan3 is not set
# CONFIG_PACKAGE_luci-app-mwan3helper is not set

# 内网穿透frpc
# CONFIG_PACKAGE_luci-app-frpc is not set
# CONFIG_PACKAGE_luci-app-frps is not set
# 内网穿透Zerotier
CONFIG_PACKAGE_zerotier=y
CONFIG_PACKAGE_luci-app-zerotier=y

# 带宽流量查看
CONFIG_PACKAGE_luci-app-nlbwmon=m
CONFIG_PACKAGE_luci-app-wrtbwmon=m

# Turbo ACC 网络加速,二选1,建议sfe
CONFIG_PACKAGE_luci-app-sfe=m
# CONFIG_PACKAGE_luci-app-flowoffload is not set

# KMS激活服务器
CONFIG_DEFAULT_luci-app-vlmcsd=m
# FTP服务器
# CONFIG_DEFAULT_luci-app-vsftpd is not set
# 上网时间控制
CONFIG_PACKAGE_luci-app-accesscontrol=m
# BT下载
# CONFIG_PACKAGE_luci-app-transmission is not set
# WiFi访客网络
# CONFIG_PACKAGE_luci-app-guest-wifi is not set
# 网络设置向导
CONFIG_PACKAGE_luci-app-meshwizard=m
# 根据IP限速
CONFIG_PACKAGE_luci-app-eqos=m

# ==========luci-theme==========
# 修改主题配置
# CONFIG_PACKAGE_luci-theme-bootstrap is not set
CONFIG_PACKAGE_luci-theme-argon=y
CONFIG_PACKAGE_luci-app-argon-config=m
# others
EOF
