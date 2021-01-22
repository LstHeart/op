#!/bin/bash
#========================================================================================================================
# https://github.com/ophub/op
# Description: Automatically Build OpenWrt for Phicomm-N1
# Function: Diy script (After Update feeds, Modify the default IP, hostname, theme, add/remove software packages, etc.)
# Copyright (C) 2020 https://github.com/P3TERX/Actions-OpenWrt
# Copyright (C) 2020 https://github.com/ophub/op
#========================================================================================================================

# Modify default IP（FROM 192.168.1.1 CHANGE TO 192.168.31.8）
sed -i 's/192.168.1.1/192.168.31.8/g' package/base-files/files/bin/config_generate
# Modify default theme（FROM uci-theme-bootstrap CHANGE TO luci-theme-material）
# sed -i 's/luci-theme-bootstrap/luci-theme-material/g' ./feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' ./feeds/luci/collections/luci/Makefile
# Modify default root's password（FROM 'password'[$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.] CHANGE TO 'your password'）
# sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' /etc/shadow
sed -i 's/root::0:0:99999:7:::/root:password:0:0:99999:7:::/g' /etc/shadow
# sed -i 's#openwrt.proxy.ustclug.org#mirrors.bfsu.edu.cn\\/openwrt#' package/lean/default-settings/files/zzz-default-settings
sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' package/lean/luci-app-cpufreq/Makefile

# Mydiy-luci-app-and-theme（use to /.config luci-app&theme）
# 修改.config中的app配置或主题配置
# ==========luci-app==========
cat >> .config <<EOF
# ==========add from diy-part2.sh or open the origin plugin（Mydiy-luci-app-and-theme）==========
# CONFIG_PACKAGE_luci-app-smartdns is not set
# 新增或打开需要添加的插件(luci-app)
CONFIG_PACKAGE_luci-app-smartdns=y  #DNS防污染插件
CONFIG_PACKAGE_luci-app-socat=y #网络端口转发插件
CONFIG_PACKAGE_luci-app-jd-dailybonus=y #京东签到插件
CONFIG_PACKAGE_luci-app-ttnode=y    #甜糖星愿自动收集插件
CONFIG_PACKAGE_luci-app-wrtbwmon=y  #查看各终端实时流量网速的插件
# CONFIG_PACKAGE_luci-app-verysync=y  #微力同步插件
# CONFIG_PACKAGE_luci-app-serverchan=y  #Server酱推送插件
CONFIG_PACKAGE_luci-app-wol=y #网络唤醒wol
CONFIG_PACKAGE_luci-lib-docker=y #docker直接管理
CONFIG_PACKAGE_luci-app-dockerman=y #docker直接管理

#=============customerize dependences=====================
# 京东签到插件依赖
CONFIG_PACKAGE_luasocket=y
CONFIG_PACKAGE_lua-md5=y
CONFIG_PACKAGE_lua-cjson=y
CONFIG_PACKAGE_luasec=y
# 网络唤醒etherwake
CONFIG_PACKAGE_etherwake=y
#=============================================
EOF
# ==========luci-theme==========
cat >> .config <<EOF
CONFIG_PACKAGE_luci-theme-argon=y
EOF