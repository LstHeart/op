#!/bin/bash
#========================================================================================================================
# https://github.com/ophub/op
# Description: Automatically Build OpenWrt for Phicomm-N1
# Function: Diy script (Before Update feeds, Modify the default IP, hostname, theme, add/remove software packages, etc.)
# Copyright (C) 2020 https://github.com/P3TERX/Actions-OpenWrt
# Copyright (C) 2020 https://github.com/ophub/op
# 此脚本用于在 update feeds 之前的相关修改
#========================================================================================================================
# cd openwrt
# other
# 添加三方包，删除原有包、主题等
(
    cd package

    if [ -d "luci-sirpdboy-package" ]; then
        for line in $(ls | grep "luci-*"); do
            (
                rm -rf ${line} && sync
            )
        done
    fi
    git clone --depth 1 https://github.com/sirpdboy/sirpdboy-package.git luci-sirpdboy-package
    git clone --depth 1 https://github.com/jerrykuku/luci-app-jd-dailybonus.git
    git clone --depth 1 https://github.com/jerrykuku/luci-app-ttnode.git
    git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon.git -b 18.06
    git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config.git
    git clone --depth 1 https://github.com/lisaac/luci-lib-docker.git
    git clone --depth 1 https://github.com/lisaac/luci-app-dockerman.git
    sudo rm -rf lean/{samba4,luci-app-samba4,luci-theme-argon,luci-lib-docker,qBittorrent}
)

# Change feeds source
cat >./feeds.conf.default<<-EOF
# src-git packages https://github.com/coolsnowwolf/packages
# src-git luci https://github.com/coolsnowwolf/luci
src-git packages https://github.com/Lienol/openwrt-packages.git;main
src-git luci https://github.com/luci/Lienol/openwrt-luci.git;18.06
src-git routing https://git.openwrt.org/feed/routing.git
src-git telephony https://git.openwrt.org/feed/telephony.git
src-git freifunk https://github.com/freifunk/openwrt-packages.git
src-git kenzo https://github.com/kenzok8/openwrt-packages
src-git small https://github.com/kenzok8/small
EOF
