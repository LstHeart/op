#!/bin/bash
#========================================================================================================================
# https://github.com/ophub/op
# Description: Automatically Build OpenWrt for Phicomm-N1
# Function: Diy script (Before Update feeds, Modify the default IP, hostname, theme, add/remove software packages, etc.)
# Copyright (C) 2020 https://github.com/P3TERX/Actions-OpenWrt
# Copyright (C) 2020 https://github.com/ophub/op
# 此脚本用于在 update feeds 之前的相关修改
# cd openwrt
# other
# 添加三方包，删除原有包、主题等
(
    cd package

    if [ -d "luci-sirpdboy-package" ]; then
        for line in $(ls | grep "luci-*"); do
            (
                cd ${line} && git pull
            )
        done
    else
        git clone --depth 1 https://github.com/sirpdboy/sirpdboy-package.git luci-sirpdboy-package
        git clone --depth 1 https://github.com/jerrykuku/luci-app-jd-dailybonus.git
        git clone --depth 1 https://github.com/jerrykuku/luci-app-ttnode.git
        git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon.git -b 18.06
        git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config.git
        git clone --depth 1 https://github.com/lisaac/luci-lib-docker.git
        git clone --depth 1 https://github.com/lisaac/luci-app-dockerman.git
    fi

    sudo rm -rf lean/{samba4,luci-app-samba4,luci-theme-argon,luci-lib-docker,qBittorrent}
)
# Uncomment a feed source
sed -i 's/#src-git helloworld/src-git helloworld/g' ./feeds.conf.default
# sed -i 's/\"#src-git\"/\"src-git\"/g' feeds.conf.default

# Add a feed source
# sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default

# Repalce a feed source
# sed -i "s/coolsnowwolf\/luci/Lienol\/openwrt-luci.git;18.06/" ./feeds.conf.default
# sed -i "s/coolsnowwolf\/packages/Lienol\/openwrt-packages.git;main/" ./feeds.conf.default
