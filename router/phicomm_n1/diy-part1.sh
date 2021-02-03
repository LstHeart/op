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
    git clone --depth 1 --recurse-submodules https://github.com/LstHeart/op-package.git lstheart-packages
    # git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon.git -b 18.06
    # sudo rm -rf lean/{luci-theme-argon,luci-lib-docker,qBittorrent,luci-app-jd-dailybonus}
    sudo rm -rf lean/{qBittorrent,luci-app-qbittorrent,v2ray,v2ray-plugin,shadowsocksr-libev,trojan,kcptun,ipt2socks}
    cp -Rf lstheart-packages/* ./lean/
    rm -rf ./lstheart-packages
)

# Change feeds source
